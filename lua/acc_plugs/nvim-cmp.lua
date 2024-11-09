local cmp = require("cmp")
local lspkind = require("lspkind")
local cmp_buffer = require("cmp_buffer")

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
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. (strings[1] or "") .. " "
      kind.menu = "    (" .. (strings[2] or "") .. ")"

      return kind
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "snippy", max_item_count = 5 },
    { name = "nvim_lua", ft = "lua" },
    { name = "path" },
  }, { buffer }),
})

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
