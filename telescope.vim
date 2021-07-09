lua require("luisiacc")

lua require('telescope').load_extension('coc')
nnoremap <leader>fw :lua require('telescope.builtin').grep_string(require('telescope.themes').get_ivy{ path_display = "shorten", search = vim.fn.input("Grep For > ")})<CR>
noremap <leader>ps :lua require('telescope.builtin').live_grep(require('telescope.themes').get_ivy{ path_display = "shorten", only_sort_text = true })<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files(require('telescope.themes').get_ivy({}))<CR>
nnoremap <Leader>fs :lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy({}))<CR>
nnoremap <Leader>fb :lua require('telescope.builtin').file_browser(require('telescope.themes').get_ivy({}))<CR>

nnoremap <Leader>em :Telescope find_files cwd=~/.config/nvim<CR>

nnoremap <leader>pw :lua require('telescope.builtin').live_grep(require('telescope.themes').get_ivy{ path_display = "shorten", search = vim.fn.expand("<cword>") })<CR>
" nnoremap <leader>ff :lua require('telescope.builtin').grep_string{ path_display = "shorten", word_match = "-w", only_sort_text = true, search = '' }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>t :lua require('telescope.builtin').tags(require('telescope.themes').get_ivy({path_display = "shorten", only_sort_text = true}))<CR>
" nnoremap <leader>t :Tags<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>F <cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find(require'telescope.themes'.get_dropdown { border = true, previewer = false, width = 0.70 })<CR>
" nnoremap <leader>pc :lua require('telescope.builtin').git_branches()<CR>

