local cmp = require("cmp")
local lspkind = require("lspkind")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local snippy = require("snippy")
-- border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
-- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
-- ╘══════╛
local function border(hl_name)
  return {
    { "╭", hl_name },
    { "-", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╛", hl_name },
    { "═", hl_name },
    { "╘", hl_name },
    { "│", hl_name },
  }
end

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
  max_item_count = 10,
  option = {
    get_bufnrs = function()
      local buf = vim.api.nvim_get_current_buf()
      local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
      -- local lines = vim.api.nvim_buf_line_count(buf)
      if byte_size > 256 * 1024 then -- 0.256 Megabyte max
        return {}
      end
      return { buf }
    end,
  },
}

cmp.setup({
  enabled = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_line_count(bufnr)
    if lines > 5000 then
      return false
    end
    return true
  end,
  performance = {
    debounce = 1000,
    fetching_timeout = 1000,
  },
  window = {
    completion = {
      border = border("CmpBorder"),
    },
    documentation = {
      border = border("CmpDocBorder"),
    },
  },
  sorting = {
    comparators = {
      compare.locality,
      compare.exact,
      compare.scopes,
      compare.recently_used,
      compare.score,
      compare.sort_text,
      compare.kind,
    },
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      require("snippy").expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        utilsnips = "[snip]",
      },
    }),
  },
  sources = cmp.config.sources({
    { name = "snippy", max_item_count = 5 },
    { name = "nvim_lua", max_item_count = 10, ft = "lua" },
    { name = "nvim_lsp", max_item_count = 10 },
    { name = "path", max_item_count = 10 },
    buffer,
  }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  enabled = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_line_count(bufnr)
    if lines > 5000 then
      return false
    end
    return true
  end,
  sources = { buffer },
  mapping = cmp.mapping.preset.cmdline(),
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  enabled = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_line_count(bufnr)
    if lines > 5000 then
      return false
    end
    return true
  end,
  sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
  mapping = cmp.mapping.preset.cmdline(),
})
