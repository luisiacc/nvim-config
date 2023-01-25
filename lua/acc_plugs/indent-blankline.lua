vim.opt.list = true
-- vim.g.indent_blankline_char = "│"
vim.g.indent_blankline_char = "⋅"
vim.g.indent_blankline_space_char_blankline =  "⋅"
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup({
  buftype_exclude = { "terminal", "telescope", "nofile" },
  filetype_exclude = { "help", "dashboard", "packer", "NvimTree", "Trouble", "TelescopePrompt", "Float" },
  -- show_current_context = true,
  -- show_current_context_start = false,
  show_end_of_line = true,
  show_trailing_blankline_indent = false,
  use_treesitter = true,
  space_char_blankline = "⋅",
})
