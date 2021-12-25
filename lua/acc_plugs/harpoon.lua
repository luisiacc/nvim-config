require("telescope").load_extension("harpoon")

-- vim.cmd([[nnoremap <leader>h :lua require("harpoon.ui").toggle_quick_menu()<CR>]])
vim.cmd([[nnoremap <leader>h :Telescope harpoon marks<CR>]])
vim.cmd([[nnoremap <leader>am :lua require("harpoon.mark").add_file()<CR>]])
vim.cmd([[nnoremap <leader>an :lua require("harpoon.ui").nav_next()<CR>]])
vim.cmd([[nnoremap <leader>ap :lua require("harpoon.ui").nav_prev()<CR>]])
