""command! -nargs=1 CFont silent execute 'silent !python3 /Users/Luis/projects/change_alacritty_font.py -f ' . <q-args> command! -nargs=1 CHeight silent execute 'silent !python3 /Users/Luis/projects/change_alacritty_font.py -o ' . <q-args>
"command! -nargs=1 CSize silent execute 'silent !python3 /Users/Luis/projects/change_alacritty_font.py -s ' . <q-args>
"command! -nargs=1 CWidth silent execute 'silent !python3 /Users/Luis/projects/change_alacritty_font.py -w ' . <q-args>

"command! -nargs=0 CBig silent execute 'silent !python3 /Users/Luis/projects/change_alacritty_font.py -o 10'
"command! -nargs=0 DHeight silent execute 'silent !python3 /Users/Luis/projects/change_alacritty_font.py --decrease-height'
"command! -nargs=0 IHeight silent execute 'silent !python3 /Users/Luis/projects/change_alacritty_font.py --increase-height'

"command! -nargs=0 ResetTerminal silent execute 'silent !python3 /Users/Luis/projects/change_alacritty_font.py -s 9 -o 7 -w 0'

map <C-1> :DHeight<CR>
map <C-2> :IHeight<CR>
map <C-3> :ResetTerminal<CR>
map <C-4> :CBig<CR>

"auto cmd group
augroup vimrc_autocmd
    autocmd!
    " autocmd BufWritePre *.py silent execute ':Black'
    " autocmd VimEnter,VimLeave * silent !tmux set status
    " autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml CocPrettier
    " autocmd BufNewFile,BufRead *.vim,*.vimrc setlocal syntax=vim
    " autocmd FileType netrw setlocal syntax=netrw
    " autocmd FileType fugitive setlocal syntax=fugitive
    " autocmd BufEnter *.js,*.jsx,*.ts,*.tsx,*.py,*.lua,*.rs,*.cpp,*.toml,*.json silent execute ':setlocal syntax=OFF'
    autocmd FileType htmldjango setlocal syntax=htmldjango
augroup END

lua require("luisiacc.colorscheme")

function DisableHighlightsOnBuffer()
    exec 'TSBufDisable hightlight'
    exec 'TSBufDisable indent'
    exec 'TSBufDisable rainbow'
    setlocal syntax=ON
endfunction

function EnableHighlightsOnBuffer()
    exec 'TSBufEnable hightlight'
    exec 'TSBufEnable indent'
    exec 'TSBufEnable rainbow'
    setlocal syntax=OFF
endfunction


function EnableAllTreesitter()
    exec 'TSEnable hightlight'
    exec 'TSEnable indent'
    exec 'TSEnable rainbow'
    exec 'TSEnable endwise'
    exec 'TSEnable autotag'
    exec 'TSEnable playground'
endfunction

command! -nargs=0 QWE silent call EnableAllTreesitter()
