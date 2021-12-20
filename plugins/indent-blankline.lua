vim.g.indent_blankline_char = "│"
-- " set list listchars=space:·,trail:~
-- "char = '·",
-- " vim.g.indent_blankline_space_char = '·'
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_buftype_exclude = { "terminal", "telescope" }
vim.g.indent_blankline_filetype_exclude = {
	"help",
	"startify",
	"dashboard",
	"packer",
	"neogitstatus",
	"NvimTree",
	"Trouble",
}
vim.g.indent_blankline_context_patterns = {
	"def",
	"class",
	"return",
	"function",
	"method",
	"^if",
	"^while",
	"jsx_element",
	"^for",
	"^object",
	"^table",
	"block",
	"arguments",
	"if_statement",
	"else_clause",
	"jsx_element",
	"jsx_self_closing_element",
	"try_statement",
	"catch_clause",
	"import_statement",
	"operation_type",
}
