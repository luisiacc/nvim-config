set nocompatible
set encoding=utf-8
set mouse=a
set synmaxcol=500
set foldlevelstart=20
set noshowmode
set signcolumn=yes
set laststatus=3

set diffopt=vertical

let g:json_ignore_conceal=1
let g:html_ignore_conceal=1

"open local vimrc first
set exrc

" indent guide
"set listchars=tab:\|\
"set list
"
"folds
set timeoutlen=400
set ttimeoutlen=0
"
set mmp=2000000

" set guicursor=
set scrolloff=5
set hidden
set switchbuf=useopen

set noerrorbells
set cursorline
set autoread
set showcmd
" set showmatch
set magic
set expandtab
set clipboard+=unnamedplus

set nonu "rnu
set nowrap
set ignorecase " case-insensitive searching
set smartcase  " but become case-sensitive if you type uppercase characters
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set nohlsearch
set linespace=10
set t_Co=256
set t_ut=""
set t_u7=
set t_md=

set updatetime=100
set colorcolumn=120
set wildmenu
set guitablabel=\[%N\]\ %t\ %M
set guioptions-=T guioptions-=m

" Do NOT yank with x/s
nnoremap x "_x
nnoremap s "_s
set completeopt=menu,menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

set termguicolors
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

