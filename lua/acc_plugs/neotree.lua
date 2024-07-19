require("neo-tree").setup({
  window = {
    mappings = {
      ["o"] = "open",
    },
  },
  filesystem = {
    hijack_netrw_behavior = "open_current",
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {},
    },
    window = {
      mappings = {
        ["o"] = "open",
      },
    },
  },
})

vim.keymap.set("n", "<leader>ce", "<cmd>Neotree toggle reveal<CR>")
vim.keymap.set("n", "<leader>o", "<cmd>Neotree current reveal<CR>")
