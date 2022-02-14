local configs = {
  "bqf",
  "colorizer",
  "comment",
  "copilot",
  "diffview",
  -- "floaterm",
  "fugitive",
  "gitsigns",
  "harpoon",
  -- "hop",
  "indent-blankline",
  "lsp-config",
  "lualine",
  "nvim-gps",
  "nvim_autopairs",
  "nvimtree",
  "snippy",
  "spectre",
  -- "tabline",
  "telescope",
  "todo_comments",
  "toggleterm",
  "treesitter",
  "trouble",
  "vim-test",
  "zen-mode",
}

for _, plugin in ipairs(configs) do
  require("acc_plugs." .. plugin)
end
