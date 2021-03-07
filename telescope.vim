lua require("luisiacc")

nnoremap <leader>fw :lua require('telescope.builtin').grep_string({ shorten_path = true, search = vim.fn.input("Grep For > ")})<CR>
noremap <leader>ps :lua require('telescope.builtin').live_grep({ shorten_path = true, only_sort_text = true })<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>fs :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>pw :lua require('telescope.builtin').grep_string { shorten_path = true, search = vim.fn.expand("<cword>") }<CR>
" nnoremap <leader>ff :lua require('telescope.builtin').grep_string{ shorten_path = true, word_match = "-w", only_sort_text = true, search = '' }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>t :lua require('telescope.builtin').tags{shorten_path = true}<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>bs <cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find(require'telescope.themes'.get_dropdown { border = true, previewer = false })<CR>
" nnoremap <leader>pc :lua require('telescope.builtin').git_branches()<CR>

