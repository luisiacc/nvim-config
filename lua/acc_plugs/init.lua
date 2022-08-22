vim.g.autocomplete_tool = "coq"
vim.g.using_coq = vim.g.autocomplete_tool == "coq"
vim.g.using_cmp = vim.g.autocomplete_tool == "cmp"

if vim.g.using_coq then
  require("acc_plugs.coq")
else
  require("acc_plugs.cmp")
end

local configs = {
  --  "bqf",
  "nvim-gps",
  "symbols",
  "colorizer",
  "comment",
  "copilot",
  "debugger",
  "diffview",
  "fugitive",
  "feline",
  "gitsigns",
  "harpoon",
  "indent-blankline",
  "lsp-config",
  -- "lualine",
  "neoscroll",
  "nvim_autopairs",
  "nvimtree",
  "snippy",
  "spectre",
  "startify",
  "telescope",
  "todo_comments",
  "toggleterm",
  "treesitter",
  "trouble",
  "vim-test",
  "zen-mode",
  -- "floaterm",
  -- "hop",
  -- "tabline",
}

for _, plugin in ipairs(configs) do
  require("acc_plugs." .. plugin)
end
