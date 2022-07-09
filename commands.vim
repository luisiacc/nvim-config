command! -nargs=0 CocPrettier :call CocAction('runCommand', 'prettier.formatFile')
command! -nargs=0 FormatDjango :call CocAction('runCommand', 'htmldjango.djhtml.format')
command! -nargs=1 CFont silent execute 'silent !python3 /home/acc/projects/change_alacritty_font.py -f ' . <q-args>
command! -nargs=1 CHeight silent execute 'silent !python3 /home/acc/projects/change_alacritty_font.py -o ' . <q-args>
command! -nargs=1 CSize silent execute 'silent !python3 /home/acc/projects/change_alacritty_font.py -s ' . <q-args>
command! -nargs=1 CWidth silent execute 'silent !python3 /home/acc/projects/change_alacritty_font.py -w ' . <q-args>

command! -nargs=0 CBig silent execute 'silent !python3 /home/acc/projects/change_alacritty_font.py -o 10'
command! -nargs=0 DHeight silent execute 'silent !python3 /home/acc/projects/change_alacritty_font.py --decrease-height'
command! -nargs=0 IHeight silent execute 'silent !python3 /home/acc/projects/change_alacritty_font.py --increase-height'

command! -nargs=0 ResetTerminal silent execute 'silent !python3 /home/acc/projects/change_alacritty_font.py -s 9 -o 7 -w 0'

map <A-1> :DHeight<CR>
map <A-2> :IHeight<CR>
map <A-3> :ResetTerminal<CR>
map <A-4> :CBig<CR>

"auto cmd group
augroup vimrc_autocmd
    autocmd!
    " autocmd BufWritePre *.py silent execute ':Black'
    " autocmd VimEnter,VimLeave * silent !tmux set status
    " autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml CocPrettier
    autocmd BufNewFile,BufRead *.vim,*.vimrc setlocal syntax=vim
    autocmd FileType netrw setlocal syntax=netrw
    autocmd BufEnter *.js,*.jsx,*.ts,*.tsx,*.py,*.lua,*.rs,*.cpp silent execute ':setlocal syntax=OFF'
augroup END

nnoremap <A-n> <cmd>lua require("luisiacc.cycle_colorschemes").go_to_scheme(-1)<cr>
nnoremap <A-m> <cmd>lua require("luisiacc.cycle_colorschemes").go_to_scheme(1)<cr>
