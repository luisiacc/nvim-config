nnoremap Y y$
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ? ?<c-g>u
inoremap ! !<c-g>u

"Fix visual indenting
vmap < <gv
vmap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Path completion with custom source command
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

" remap tab navigation
" nnoremap <leader>, gT
" nnoremap <leader>. gt
nnoremap <silent><leader>. :BufferLineCycleNext<CR>
nnoremap <silent><leader>, :BufferLineCyclePrev<CR>

nnoremap <leader>2 gg:q!<CR>
inoremap jj <Esc>


" replace word
nnoremap <Leader>rw :%s/\<<C-r><C-w>\>/
nnoremap <Leader>rr :%s/<C-r><C-w>/

nnoremap <leader>s :w!<CR>
nnoremap <leader>r :noautocmd w!<CR>
nnoremap - *zz
" nnoremap <leader>t :Tags<CR>

nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>

nnoremap <leader>me :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

nnoremap <leader>ps :Rg<SPACE>
nnoremap <silent> <C-Right> :vertical resize -2<CR>
nnoremap <silent> <C-Left> :vertical resize +2<CR>
nnoremap <silent> <C-Up> :resize -1<CR>
nnoremap <silent> <C-Down> :resize +1<CR>

" compares current file to last revision
nmap <leader>lr :vert diffsplit #<CR>


nnoremap <leader>d :tabedit %<CR>

nnoremap <leader>js :set filetype=javascriptreact<CR>

nnoremap <C-x> :cnext<CR>
nnoremap <C-z> :cprev<CR>
nnoremap <C-q> :call ToggleQFList()<CR>

nmap <C-e> <C-f>

" nnoremap <leader>rs :setlocal syntax=OFF

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

nmap <leader>q :tabedit /mnt/c/Users/Luis/AppData/Roaming/alacritty/alacritty.yml<CR>
nmap <leader>qq :tabedit /mnt/c/Users/Luis/.config/wezterm/wezterm.lua<CR>

nmap s <Plug>Lightspeed_s
