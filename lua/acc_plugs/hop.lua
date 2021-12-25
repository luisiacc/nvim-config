require("hop").setup()

vim.cmd([[nmap <leader><leader>l <cmd>HopLine<CR>]])
vim.cmd([[nmap <leader><leader>w <cmd>HopWordAC<CR>]])
vim.cmd([[nmap <leader><leader>b <cmd>HopWordBC<CR>]])
vim.cmd([[nmap <leader><leader>c <cmd>HopChar1<CR>]])
vim.cmd([[nmap <leader><leader>d <cmd>HopChar2<CR>]])

vim.cmd([[highlight HopNextKey guibg=#353535]])
vim.cmd([[highlight HopNextKey1 guibg=#353535]])
vim.cmd([[highlight HopNextKey2 guibg=#353535]])
