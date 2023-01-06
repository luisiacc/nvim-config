-- Sweet Sweet FuGITive
-- nmap <leader>gc :GBranches<CR>
vim.cmd([[nmap <leader>as <cmd>G rebase -i --autosquash]])
vim.cmd([[nmap <leader>df <cmd>Gdiffsplit<CR>]])
vim.cmd([[nmap <leader>ru <cmd>G reset HEAD~1<CR>]])
vim.cmd([[nmap <leader>cb <cmd>G checkout]])
vim.cmd([[nmap <leader>nb <cmd>G checkout -b]])
vim.cmd([[nmap <leader>co <cmd>Gcommit<CR>]])
vim.cmd([[nmap <leader>gh <cmd>diffget //2<CR>]])
vim.cmd([[nmap <leader>gl <cmd>diffget //3<CR>]])
vim.cmd([[nmap <leader>gg <cmd>G<CR>]])
vim.cmd([[nmap <leader>dg <cmd>diffget<CR>]])
vim.cmd([[nmap <leader>dp <cmd>diffput<CR>]])
