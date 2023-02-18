vim.cmd([[imap <silent><script><expr> <C-s> copilot#Accept("\<CR>")]])
vim.g.copilot_no_tab_map = true
vim.g.copilot_filetypes = { TelescopePrompt = false }
-- vim.b.copilot_enabled = false

-- create command to disable copilot
vim.cmd([[command! CD :lua vim.b.copilot_enabled = false]])
vim.cmd([[command! CE :lua vim.b.copilot_enabled = true]])

vim.keymap.set("n", "<leader>o", "<cmd>Copilot panel<CR>")
