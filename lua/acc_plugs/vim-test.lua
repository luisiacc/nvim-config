-- these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
vim.cmd([[nmap <silent> t<C-n> :TestNearest<CR>]])
vim.cmd([[nmap <silent> t<C-f> :TestFile<CR>]])
vim.cmd([[nmap <silent> t<C-s> :TestSuite<CR>]])
vim.cmd([[nmap <silent> t<C-l> :TestLast<CR>]])
vim.cmd([[nmap <silent> t<C-g> :TestVisit<CR>]])
