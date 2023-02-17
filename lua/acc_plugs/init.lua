if vim.g.using_coq then
  require("acc_plugs.coq")
else
  require("acc_plugs.nvim-cmp")
  require("acc_plugs.nvim-snippy")
end

local configs = {
  "nvim-colorizer",
  "comment",
  "copilot",
  "nvim-dap",
  "diffview",
  "vim-fugitive",
  "feline",
  "gitsigns",
  "noice",
  "harpoon",
  "indent-blankline",
  "nvim-lspconfig",
  "nvim-autopairs",
  "nvim-tree",
  "nvim-spectre",
  "vim-startify",
  "telescope",
  "todo-comments",
  "toggleterm",
  "nvim-treesitter",
  "vim-test",
}

for _, plugin in ipairs(configs) do
  require("acc_plugs." .. plugin)
end
