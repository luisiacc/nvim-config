local configs = {
--  "bqf",
  "colorizer",
  "comment",
  "copilot",
  "debugger",
  "diffview",
  "fugitive",
  "gitsigns",
  "harpoon",
  "indent-blankline",
  "lsp-config",
  "lualine",
  "neoscroll",
  "nvim-gps",
  "nvim_autopairs",
  "nvimtree",
  "snippy",
  "spectre",
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
