" Black for python
"let g:black_virtualenv="/mnt/c/Users/acc/projects__/acubliss/core/.venv/"
nnoremap <leader>fm :lua vim.lsp.buf.formatting()<CR>

nnoremap Y y$
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ? ?<c-g>u
inoremap ! !<c-g>u

inoremap jj <Esc>
"Fix visual indenting
vmap < <gv
vmap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <leader>cw :CocSearch <C-R>=expand("<cword>")<CR><CR>
" nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
" nnoremap <leader>phw :h <C-R>=expand("<cword>")<CR><CR>
" nnoremap <C-p> :GFiles<CR>
" nnoremap <leader>ff :Ag<CR>
" Path completion with custom source command
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

" remap tab navigation
nnoremap <leader>, gT
nnoremap <leader>. gt
nnoremap <leader>w gg:q!<CR>
nnoremap <leader>ee :noh<CR>
inoremap jj <Esc>

nnoremap <leader>ee :noh<CR>
inoremap jj <Esc>


" replace word
nnoremap <Leader>rw :%s/\<<C-r><C-w>\>/
nnoremap <Leader>rr :%s/<C-r><C-w>/


" Git
nnoremap <leader>c :Commits<CR>
nnoremap <leader>bc :BCommits<CR>

nnoremap <leader>cs :CocSearch<SPACE>
nnoremap <leader>fs :Files<CR>
nnoremap <leader>s :w!<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap - *zz
" nnoremap <leader>t :Tags<CR>

nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>

nnoremap <leader>me :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

nnoremap <leader>ps :Rg<SPACE>
noremap <silent> <C-Right> :vertical resize -5<CR>
noremap <silent> <C-Left> :vertical resize +5<CR>
noremap <silent> <C-Up> :resize -1<CR>
noremap <silent> <C-Down> :resize +1<CR>

" compares current file to last revision
nmap <leader>lr :vert diffsplit #<CR>

" todo
nnoremap <leader>e :tabedit todo.md<cr>


nnoremap <leader>d :tabedit %<CR>

nnoremap <leader>js :set filetype=javascriptreact<CR>

nnoremap <C-x> :cnext<CR>
nnoremap <C-z> :cprev<CR>
nnoremap <C-q> :call ToggleQFList()<CR>
nnoremap <C-e> :call ToggleLocList()<CR>

nnoremap <leader>rs :setlocal syntax=OFF

let g:acc_loc_list = 0
let g:acc_quickfix_list = 0

fun! ToggleQFList()
    if g:acc_quickfix_list == 1
        let g:acc_quickfix_list = 2
        cclose
    else
        let g:acc_quickfix_list = 1
        copen
    endif
endfun


fun! ToggleLocList()
    if g:acc_loc_list == 1
        let g:acc_loc_list = 0
        lclose
    else
        let g:acc_loc_list = 1
        lopen
    endif
endfun

nmap <leader>q :tabedit /mnt/c/Users/acc/AppData/Roaming/alacritty/alacritty.yml<CR>


