require("spectre").setup({
	highlight = {
		ui = "String",
		search = "DiffChange",
		replace = "debugPc",
	},
})
vim.cmd([[nnoremap <leader>S :lua require('spectre').open()<CR>]])

-- "search current word
vim.cmd([[nnoremap <leader>cw :lua require('spectre').open_visual({select_word=true})<CR>]])
vim.cmd([[vnoremap <leader>rs :lua require('spectre').open_visual()<CR>]])
-- "  search in current file
vim.cmd([[nnoremap <leader>fn viw:lua require('spectre').open_file_search()<cr>]])
