require("trouble").setup({
  use_lsp_diagnostic = true,
})
vim.keymap.set("n", "<leader>u", "<cmd>TroubleToggle<CR>")
