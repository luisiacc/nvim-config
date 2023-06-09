nnoremap Y y$
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ? ?<c-g>u
inoremap ! !<c-g>u

"Fix visual indenting
vmap < <gv
vmap > >gv

" Path completion with custom source command
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

" remap tab navigation
nnoremap <leader>. gt
nnoremap <leader>, gT
" nnoremap <silent><leader>. <cmd>BufferLineCycleNext<CR>
" nnoremap <silent><leader>, <cmd>BufferLineCyclePrev<CR>

nnoremap <leader>2 gg<cmd>q!<CR>


" replace word
nnoremap <Leader>rw :%s/\<<C-r><C-w>\>/
nnoremap <Leader>rr :%s/<C-r><C-w>/
vnoremap <Leader>rw <kMultiply>N:%s//

nnoremap <leader>s <cmd>w!<CR>
nnoremap <leader>r <cmd>noautocmd w!<CR>
nnoremap - *zz
" nnoremap <leader>t <cmd>Tags<CR>

nnoremap <C-h> <cmd>wincmd h<CR>
nnoremap <C-j> <cmd>wincmd j<CR>
nnoremap <C-k> <cmd>wincmd k<CR>
nnoremap <C-l> <cmd>wincmd l<CR>


nnoremap <silent> <C-Right> <cmd>vertical resize -2<CR>
nnoremap <silent> <C-Left> <cmd>vertical resize +2<CR>
nnoremap <silent> <C-Up> <cmd>resize -1<CR>
nnoremap <silent> <C-Down> <cmd>resize +1<CR>

" compares current file to last revision
nmap <leader>lr <cmd>vert diffsplit #<CR>


nnoremap <leader>d <cmd>tabedit %<CR>

nnoremap <leader>js <cmd>set filetype=javascriptreact<CR>

nnoremap <C-x> <cmd>cnext<CR>
nnoremap <C-z> <cmd>cprev<CR>
nnoremap <C-q> <cmd>call ToggleQFList()<CR>

nmap <C-e> <C-f>

" nnoremap <leader>rs <cmd>setlocal syntax=OFF

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
        let g<cmd>acc_loc_list = 0
        lclose
    else
        let g:acc_loc_list = 1
        lopen
    endif
endfun

nmap <leader>qq <cmd>tabedit /Users/Luis/.config/wezterm/wezterm.lua<CR>

nmap s <Plug>Lightspeed_s
nnoremap <F5> <cmd>UndotreeToggle<CR>

" nnoremap <unique> { <cmd>call smoothie#do("{") <CR>
" vnoremap <unique> { <cmd>call smoothie#do("{") <CR>
"
" nnoremap <unique> } <cmd>call smoothie#do("}") <CR>
" vnoremap <unique> } <cmd>call smoothie#do("}") <CR>
