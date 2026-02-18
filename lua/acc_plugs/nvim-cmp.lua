local cmp = require("cmp")
local lspkind = require("lspkind")
local cmp_buffer = require("cmp_buffer")
local uv = vim.uv or vim.loop

-- border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
-- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
-- ╘══════╛

local cmp_window = require("cmp.utils.window")

cmp_window.info_ = cmp_window.info
cmp_window.info = function(self)
  local info = self:info_()
  info.scrollable = false
  return info
end

local compare = cmp.config.compare

local project_context_cache = {}
local project_root_cache = {}
local completion_item_source_cache = setmetatable({}, { __mode = "k" })
local completion_runtime_cache = {
  context_id = nil,
  package_markers = {},
  project_context = {},
  source_preference = {},
  duplicate_labels = {},
  duplicate_labels_built = false,
}

local function trim(text)
  if type(text) ~= "string" then
    return ""
  end
  return text:gsub("^%s+", ""):gsub("%s+$", "")
end

local function add_unique_string(target, seen, value)
  if type(value) ~= "string" then
    return
  end

  local normalized = trim(value)
  if normalized == "" or seen[normalized] then
    return
  end

  seen[normalized] = true
  table.insert(target, normalized)
end

local function add_package_markers(target, seen, value)
  if type(value) == "string" then
    add_unique_string(target, seen, value)
    return
  end

  if type(value) ~= "table" then
    return
  end

  for _, marker in ipairs(value) do
    add_unique_string(target, seen, marker)
  end
end

local function get_project_root()
  local bufnr = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local cache_key = bufname ~= "" and bufname or ("buf:" .. tostring(bufnr))

  if project_root_cache[cache_key] then
    return project_root_cache[cache_key]
  end

  local startpath = bufname ~= "" and bufname or uv.cwd()
  local root = vim.fs.root(startpath, { "package.json", "tsconfig.json", ".git" }) or uv.cwd()
  project_root_cache[cache_key] = root
  return root
end

local function get_project_context()
  local root = get_project_root()
  if not root then
    return {}
  end

  if project_context_cache[root] then
    return project_context_cache[root]
  end

  local context = { root = root }
  local package_json_path = vim.fs.joinpath(root, "package.json")
  local package_json_stats = uv.fs_stat(package_json_path)

  if package_json_stats and package_json_stats.type == "file" then
    local ok_read, lines = pcall(vim.fn.readfile, package_json_path)
    if ok_read and type(lines) == "table" and #lines > 0 then
      local ok_decode, parsed = pcall(vim.json.decode, table.concat(lines, "\n"))
      if ok_decode and type(parsed) == "table" and type(parsed.name) == "string" then
        context.package_name = parsed.name
      end
    end
  end

  project_context_cache[root] = context
  return context
end

local function get_considered_my_packages()
  local context = get_project_context()
  local root = context.root
  local root_realpath = root and uv.fs_realpath(root) or nil
  local project_name = root and vim.fs.basename(root) or nil
  local markers = {}
  local seen = {}

  local function collect_from(raw_value)
    if type(raw_value) == "string" then
      add_unique_string(markers, seen, raw_value)
      return
    end

    if type(raw_value) ~= "table" then
      return
    end

    if vim.tbl_islist(raw_value) then
      add_package_markers(markers, seen, raw_value)
      return
    end

    add_package_markers(markers, seen, raw_value["*"])

    if root then
      add_package_markers(markers, seen, raw_value[root])
    end

    if root_realpath and root_realpath ~= root then
      add_package_markers(markers, seen, raw_value[root_realpath])
    end

    if project_name then
      add_package_markers(markers, seen, raw_value[project_name])
    end
  end

  collect_from(vim.g.CONSIDERED_MY_PACKAGES)
  collect_from(vim.b.CONSIDERED_MY_PACKAGES)

  if type(context.package_name) == "string" then
    add_unique_string(markers, seen, context.package_name)
  end

  return markers
end

local function maybe_extract_source(text)
  if type(text) ~= "string" then
    return nil
  end

  local normalized = trim(text)
  if normalized == "" then
    return nil
  end

  local auto_import_quoted = normalized:match("[Aa]uto import from%s+['\"]([^'\"]+)['\"]")
  if auto_import_quoted then
    return auto_import_quoted
  end

  local from_paren_quoted = normalized:match("%(from%s+['\"]([^'\"]+)['\"]%)")
  if from_paren_quoted then
    return from_paren_quoted
  end

  local from_quoted = normalized:match("from%s+['\"]([^'\"]+)['\"]")
  if from_quoted then
    return from_quoted
  end

  local from_unquoted = normalized:match("from%s+([@%w_.%-%/]+)")
  if from_unquoted then
    return from_unquoted
  end

  local quoted = normalized:match("^['\"]([^'\"]+)['\"]$")
  if quoted then
    return quoted
  end

  if normalized:match("^[@#~%./]") then
    return normalized
  end

  if normalized:match("^[%w_.%-]+/[%w_.%-%/]+$") then
    return normalized
  end

  if normalized:match("^[@%w_.%-]+$") then
    return normalized
  end

  return nil
end

local function display_parts_to_text(value)
  if type(value) == "string" then
    return trim(value)
  end

  if type(value) ~= "table" then
    return nil
  end

  if type(value.text) == "string" then
    return trim(value.text)
  end

  local parts = {}
  for _, part in ipairs(value) do
    if type(part) == "string" then
      table.insert(parts, part)
    elseif type(part) == "table" and type(part.text) == "string" then
      table.insert(parts, part.text)
    end
  end

  if #parts == 0 then
    return nil
  end

  return trim(table.concat(parts, ""))
end

local function normalize_source(value)
  local as_text = display_parts_to_text(value)
  if not as_text or as_text == "" then
    return nil
  end
  return maybe_extract_source(as_text) or as_text
end

local function get_completion_item_source(item)
  if type(item) ~= "table" then
    return nil
  end

  local function extract_from_data(data)
    if type(data) ~= "table" then
      return nil
    end

    local entry_names = data.entryNames
    if type(entry_names) == "table" then
      for _, entry_name in ipairs(entry_names) do
        if type(entry_name) == "table" then
          local source = normalize_source(entry_name.source)
          if source then
            return source
          end
        end
      end
    end

    local direct_source = normalize_source(data.source)
    if direct_source then
      return direct_source
    end

    local module_specifier = normalize_source(data.moduleSpecifier)
    if module_specifier then
      return module_specifier
    end

    return nil
  end

  local source_from_data = extract_from_data(item.data)
  if source_from_data then
    return source_from_data
  end

  local candidates = {}
  local function add_candidate(value)
    local normalized = normalize_source(value)
    if normalized then
      table.insert(candidates, normalized)
    end
  end

  if type(item.labelDetails) == "table" then
    add_candidate(item.labelDetails.description)
    add_candidate(item.labelDetails.detail)
  end

  add_candidate(item.detail)

  if type(item.documentation) == "string" then
    add_candidate(item.documentation)
  elseif type(item.documentation) == "table" then
    add_candidate(item.documentation.value)
  end

  for _, candidate in ipairs(candidates) do
    if candidate and candidate ~= "" then
      return candidate
    end
  end

  return nil
end

local function get_entry_source(entry)
  local item = entry and entry.completion_item
  if type(item) ~= "table" then
    return nil
  end

  local cached = completion_item_source_cache[item]
  if cached ~= nil then
    return cached ~= false and cached or nil
  end

  local source = get_completion_item_source(item)
  completion_item_source_cache[item] = source or false
  return source
end

local function source_matches_prefix(source, marker)
  return source == marker or vim.startswith(source, marker .. "/")
end

local function is_path_like(source)
  if type(source) ~= "string" then
    return false
  end
  return source:match("^%.") ~= nil
    or source:match("^/") ~= nil
    or source:match("^~") ~= nil
    or source:match("^@/") ~= nil
    or source:match("^#/") ~= nil
    or source:find("\\", 1, true) ~= nil
end

local function get_completion_runtime(entry)
  local context_id = entry and entry.context and entry.context.id or "__no_context__"
  if completion_runtime_cache.context_id == context_id then
    return completion_runtime_cache
  end

  completion_runtime_cache.context_id = context_id
  completion_runtime_cache.package_markers = get_considered_my_packages()
  completion_runtime_cache.project_context = get_project_context()
  completion_runtime_cache.source_preference = {}
  completion_runtime_cache.duplicate_labels = {}
  completion_runtime_cache.duplicate_labels_built = false
  return completion_runtime_cache
end

local function build_duplicate_labels_for_context(context_id)
  local label_counts = {}
  local result = {}
  local all_sources = (cmp.core and cmp.core.sources) or {}

  for _, source in pairs(all_sources) do
    if source and source.name == "nvim_lsp" and source.context and source.context.id == context_id then
      local entries = source.entries or {}
      for _, entry in ipairs(entries) do
        local item = entry and entry.completion_item
        local label = item and item.label
        if type(label) == "string" and label ~= "" then
          label_counts[label] = (label_counts[label] or 0) + 1
        end
      end
    end
  end

  for label, count in pairs(label_counts) do
    if count > 1 then
      result[label] = true
    end
  end

  return result
end

local function ensure_duplicate_labels(runtime, entry)
  if runtime.duplicate_labels_built then
    return
  end

  local context_id = entry and entry.context and entry.context.id or runtime.context_id
  runtime.duplicate_labels = build_duplicate_labels_for_context(context_id)
  runtime.duplicate_labels_built = true
end

local function is_my_import_source(source, runtime)
  if type(source) ~= "string" or source == "" then
    return false
  end

  local cached = runtime.source_preference[source]
  if cached ~= nil then
    return cached
  end

  local is_mine = false

  if is_path_like(source) then
    is_mine = true
  end

  if not is_mine then
    local context = runtime.project_context
    if type(context.root) == "string" then
      if vim.startswith(source, context.root) then
        is_mine = true
      end

      if source:match("^file://") and source:find(context.root, 1, true) then
        is_mine = true
      end
    end
  end

  if not is_mine then
    for _, marker in ipairs(runtime.package_markers) do
      if source_matches_prefix(source, marker) then
        is_mine = true
        break
      end
    end
  end

  runtime.source_preference[source] = is_mine
  return is_mine
end

local function prefer_my_imports(entry1, entry2)
  if not entry1 or not entry2 then
    return nil
  end

  local source_name_1 = entry1.source and entry1.source.name
  local source_name_2 = entry2.source and entry2.source.name
  if source_name_1 ~= "nvim_lsp" or source_name_2 ~= "nvim_lsp" then
    return nil
  end

  local item1 = entry1.completion_item
  local item2 = entry2.completion_item
  if type(item1) ~= "table" or type(item2) ~= "table" then
    return nil
  end

  if item1.label ~= item2.label then
    return nil
  end

  local runtime = get_completion_runtime(entry1)
  runtime.duplicate_labels[item1.label] = true

  local source1 = get_entry_source(entry1)
  local source2 = get_entry_source(entry2)
  if not source1 and not source2 then
    return nil
  end

  local my_source1 = is_my_import_source(source1, runtime)
  local my_source2 = is_my_import_source(source2, runtime)

  if my_source1 ~= my_source2 then
    return my_source1
  end

  return nil
end

local function truncate_source_label(source, max_length)
  if type(source) ~= "string" then
    return ""
  end

  if #source <= max_length then
    return source
  end

  if max_length < 7 then
    return source:sub(1, max_length)
  end

  if is_path_like(source) then
    return "..." .. source:sub(-(max_length - 3))
  end

  return source:sub(1, max_length - 3) .. "..."
end

local buffer = {
  name = "buffer",
  option = {
    get_bufnrs = function()
      local bufs = {}
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        bufs[vim.api.nvim_win_get_buf(win)] = true
      end
      return vim.tbl_keys(bufs)
    end,
  },
}

local function disable_if_more_than_x_lines(max_lines)
  return function()
    local disabled = false
    disabled = disabled or (vim.api.nvim_buf_get_option(0, "buftype") == "prompt")
    disabled = disabled or (vim.fn.reg_recording() ~= "")
    disabled = disabled or (vim.fn.reg_executing() ~= "")

    if disabled then
      return false
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_line_count(bufnr)
    if lines > max_lines then
      return false
    end
    return true
  end
end

local custom = {
  select_first = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item({ behavior = cmp.SelectBehavior.Inset })
      cmp.confirm()
    else
      cmp.complete()
      cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      cmp.confirm()
      -- fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
    end
  end, { "i", "s" }),
  safe_enter = cmp.mapping({
    i = function(fallback)
      if cmp.visible() and cmp.get_active_entry() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
      else
        fallback()
      end
    end,
    s = cmp.mapping.confirm({ select = true }),
    c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  }),
  regular_enter = function(fallback)
    if cmp.visible() then
      cmp.confirm()
    else
      fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
    end
  end,
}

---recently_used: Entries that are used recently will be ranked higher.
---@type cmp.ComparatorFunctor
local custom_compare = setmetatable({
  records = {},
  add_entry = function(self, e)
    self.records[e.completion_item.label] = vim.loop.now()
  end,
}, {
  ---@type fun(self: table, entry1: cmp.Entry, entry2: cmp.Entry): boolean|nil
  __call = function(self, entry1, entry2)
    local t1 = self.records[entry1.completion_item.label] or -1
    local t2 = self.records[entry2.completion_item.label] or -1
    if t1 ~= t2 then
      return t1 > t2
    end
    return nil
  end,
})

cmp.setup({
  enabled = disable_if_more_than_x_lines(5000),
  preselect = cmp.PreselectMode.None,
  completion = {
    completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
    },
    -- keyword_length = 3,
  },
  sorting = {
    comparators = {
      cmp.config.compare.exact,
      prefer_my_imports,
      -- function(...)
      --   return cmp_buffer:compare_locality(...)
      -- end,
      cmp.config.compare.locality,
      cmp.config.compare.recently_used,
      cmp.config.compare.score,
      cmp.config.compare.offset,
      cmp.config.compare.sort_text,
      cmp.config.compare.order,
    },
  },
  snippet = {
    expand = function(args)
      require("snippy").expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    -- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    -- ["<CR>"] = custom.regular_enter,
    ["<CR>"] = custom.safe_enter,
    ["<C-r>"] = custom.select_first,
    -- ["<Tab>"] = custom.select_first,
    ["<C-t>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  }),
  window = {
    completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
    },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local formatted = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(formatted.kind, "%s", { trimempty = true })
      local kind_label = strings[2] or ""
      formatted.kind = " " .. (strings[1] or "") .. " "

      local runtime = get_completion_runtime(entry)
      ensure_duplicate_labels(runtime, entry)
      local label = (entry.completion_item and entry.completion_item.label) or formatted.abbr
      local source = get_entry_source(entry)
      local show_source = source and runtime.duplicate_labels[label]

      if show_source then
        formatted.menu = " [" .. truncate_source_label(source, 36) .. "]"
      else
        formatted.menu = "    (" .. kind_label .. ")"
      end

      return formatted
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "snippy", max_item_count = 5 },
    { name = "nvim_lua", ft = "lua" },
    { name = "path" },
  }, { buffer }),
})

-- Customization for Pmenu
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })

vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })

vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })

vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })

vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })

vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline("/", {
--   enabled = disable_if_more_than(5000),
--   sources = { buffer },
--   mapping = cmp.mapping.preset.cmdline(),
-- })
--
-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(":", {
--   enabled = disable_if_more_than(5000),
--   sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
--   mapping = cmp.mapping.preset.cmdline(),
-- })
