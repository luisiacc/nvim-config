if vim.g.using_coq then
  require("acc_plugs.coq")
else
  require("acc_plugs.cmp")
  require("acc_plugs.snippy")
end

local configs = {
  --  "bqf",
  "nvim-gps",
  "dressing",
  "bufferline",
  "colorizer",
  "comment",
  "copilot",
  "debugger",
  "diffview",
  "fugitive",
  "feline",
  "gitsigns",
  "noice",
  "harpoon",
  -- "indent-blankline",
  "lsp-config",
  -- "lualine",
  -- "neoscroll",
  "nvim_autopairs",
  "nvimtree",
  "spectre",
  "startify",
  "telescope",
  "todo_comments",
  "toggleterm",
  "treesitter",
  "vim-test",
  -- "zen-mode",
  -- "floaterm",
  -- "hop",
  -- "tabline",
}

for _, plugin in ipairs(configs) do
  require("acc_plugs." .. plugin)
end
