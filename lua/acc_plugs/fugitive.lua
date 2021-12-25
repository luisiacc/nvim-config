-- Sweet Sweet FuGITive
-- nmap <leader>gc :GBranches<CR>
vim.cmd([[nmap <leader>as :G rebase -i --autosquash]])
vim.cmd([[nmap <leader>df :Gdiffsplit<CR>]])
vim.cmd([[nmap <leader>ru :G reset HEAD~1<CR>]])
vim.cmd([[nmap <leader>cb :G checkout]])
vim.cmd([[nmap <leader>nb :G checkout -b]])
vim.cmd([[nmap <leader>co :Gcommit<CR>]])
vim.cmd([[nmap <leader>gh :diffget //2<CR>]])
vim.cmd([[nmap <leader>gl :diffget //3<CR>]])
vim.cmd([[nmap <leader>gg :G<CR>]])
vim.cmd([[nmap <leader>dg :diffget<CR>]])
vim.cmd([[nmap <leader>dp :diffput<CR>]])
