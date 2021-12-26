local configs = {
	"bqf",
	"colorizer",
	"copilot",
	"diffview",
	"floaterm",
	"fugitive",
	"gitsigns",
	"harpoon",
	"hop",
	"indent-blankline",
	"lsp-config",
	"lualine",
	"nvim-gps",
	"nvim_autopairs",
	"nvimtree",
	"snippy",
	"spectre",
	"telescope",
	"todo_comments",
	"treesitter",
	"trouble",
	"vim-test",
}

for _, plugin in ipairs(configs) do
	require("acc_plugs." .. plugin)
end
