" Black for python
"let g:black_virtualenv="/mnt/c/Users/acc/projects__/acubliss/core/.venv/"
nnoremap <leader>bb :Black<CR>
nnoremap <leader>fp :CocPrettier<CR>
nnoremap <leader>fm :Format<CR>

inoremap jj <Esc>
"Fix visual indenting
vmap < <gv
vmap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


filetype plugin on
nnoremap <leader>cw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>phw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>F :BLines<CR>
nnoremap <leader>an :Snippets<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <leader>ff :Ag<CR>
nnoremap <leader>sf :BLines<CR>
" Path completion with custom source command
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" remap tab navigation
nnoremap <leader>, gT
nnoremap <leader>. gt
nnoremap <leader>w :q!<CR>
nnoremap <leader>ee :noh<CR>
inoremap jj <Esc>

"Fix visual indenting
vmap < <gv
vmap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <leader>ee :noh<CR>
inoremap jj <Esc>

"Fix visual indenting
vmap < <gv
vmap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


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
nnoremap <leader>t :Tags<CR>

nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :NERDTreeFind<CR>

"nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

nnoremap <leader>ps :Rg<SPACE>
noremap <silent> <C-Right> :vertical resize -5<CR>
noremap <silent> <C-Left> :vertical resize +5<CR>
noremap <silent> <C-Up> :resize -1<CR>
noremap <silent> <C-Down> :resize +1<CR>

" Sweet Sweet FuGITive
nmap <leader>gc :GBranches<CR>
nmap <leader>as :G rebase -i --autosquash 
nmap <leader>df :Gdiffsplit<CR>
nmap <leader>ru :G reset head~1<CR>
nmap <leader>cb :G checkout 
nmap <leader>nb :G checkout -b 
nmap <leader>co :Gcommit<CR>
nmap <leader>gh :diffget //2<CR>
nmap <leader>gl :diffget //3<CR>
nmap <leader>gg :G<CR>
nmap <leader>dg :diffget<CR>
nmap <leader>dp :diffput<CR>

"coc git
nmap <leader>uc :CocCommand git.chunkUndo<CR>
nmap <leader>sc :CocCommand git.chunkStage<CR>
" compares current file to last revision
nmap <leader>lr :vert diffsplit #<CR>

" todo
nnoremap <leader>e :tabedit todo.md<cr>

"floaterm terminal
tnoremap jj <C-\><C-n>

" nnoremap <leader>p :FloatermNew eval $(ssh-agent -s) && ssh-add ~/.ssh/r.txt 
nnoremap <leader>p :FloatermToggle<CR>

nnoremap <leader>js :set filetype=javascriptreact<CR>
