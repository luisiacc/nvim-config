vim.cmd([[tnoremap jj <C-\><C-n>]])

vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8

-- nnoremap <leader>p :FloatermNew eval $(ssh-agent -s) && ssh-add ~/.ssh/r.txt
vim.cmd([[nnoremap <leader>p :FloatermToggle<CR>]])
