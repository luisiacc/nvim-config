require("luisiacc")

-- TODO: find lua way to remaps
-- " lua require('telescope').load_extension('coc')
vim.cmd(
	[[nnoremap <leader>fw :lua require('telescope.builtin').grep_string(require('telescope.themes').get_ivy{ path_display = "shorten", search = vim.fn.input("Grep For > ")})<CR>]]
)
vim.cmd(
	[[noremap <leader>ps :lua require('telescope.builtin').live_grep(require('telescope.themes').get_ivy{ path_display = "shorten", only_sort_text = true })<CR>]]
)
vim.cmd([[nnoremap <C-p> :lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy({}))<CR>]])
vim.cmd(
	[[nnoremap <Leader>fs :lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy({}))<CR>]]
)
vim.cmd(
	[[nnoremap <Leader>fb :lua require('telescope.builtin').file_browser(require('telescope.themes').get_ivy({}))<CR>]]
)

vim.cmd([[nnoremap <Leader>em :Telescope find_files cwd=~/.config/nvim<CR>]])

vim.cmd(
	[[nnoremap <leader>pw :lua require('telescope.builtin').live_grep(require('telescope.themes').get_ivy{ path_display = "shorten", search = vim.fn.expand("<cword>") })<CR>]]
)
-- " nnoremap <leader>ff :lua require('telescope.builtin').live_grep(require('telescope.themes').get_ivy{})<CR>
vim.cmd([[nnoremap <leader>ff :Ag<CR>]])
vim.cmd(
	[[nnoremap <leader>fw :lua require('telescope.builtin').grep_string(require('telescope.themes').get_ivy{ only_sort_text = true, search = '' })<CR>]]
)
vim.cmd([[nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>]])
vim.cmd(
	[[nnoremap <leader>t :lua require('telescope.builtin').tags(require('telescope.themes').get_ivy({path_display = "shorten", only_sort_text = true}))<CR>]]
)
-- " nnoremap <leader>t :Tags<CR>
vim.cmd([[nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>]])
vim.cmd(
	[[nnoremap <leader>F <cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find(require'telescope.themes'.get_dropdown { border = true, previewer = false, layout_config={width = 0.70} })<CR>]]
)
vim.cmd(
	[[nnoremap <leader>gc :lua require('telescope.builtin').git_branches(require('telescope.themes').get_ivy{})<CR>]]
)
