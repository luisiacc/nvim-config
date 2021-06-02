" Vim with all enhancements
set nocompatible 
let mapleader=" "
syntax enable
set encoding=utf-8
set mouse=a

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

set guicursor=
set scrolloff=5
set foldmethod=expr   
set foldnestmax=10
set nofoldenable
set foldlevel=2
set hidden

set noerrorbells
set diffopt+=vertical
set nocursorline
set autoread
set showcmd
set showmatch
set magic
"set tabstop=4 softtabstop=4
" set shiftwidth=4
set expandtab
set clipboard+=unnamedplus

filetype indent on
set smartindent
set autoindent

set nu rnu
set nowrap
set smartcase
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

highlight ColorColumn ctermbg=0 guibg=lightgrey
set guioptions-=T guioptions-=m

let g:ale_disable_lsp = 1

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set rtp +=~/.vim
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'fisadev/vim-isort'
" Plug 'brentyi/isort.vim'
"Plug 'sheerun/vim-polyglot'

Plug 'vim-test/vim-test'
Plug 'pangloss/vim-javascript'
Plug 'hail2u/vim-css3-syntax'

Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'

Plug 'zirrostig/vim-schlepp'
Plug 'jremmen/vim-ripgrep'
" Plug 'leafgarland/typescript-vim'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
"Plug 'dense-analysis/ale'
" Plug 'tweekmonster/django-plus.vim'
" Plug 'lyuts/vim-rtags'
" Plug 'git@github.com:kien/ctrlp.vim.git'
Plug 'easymotion/vim-easymotion'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

"Plug 'hardcoreplayers/spaceline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'honza/vim-snippets'
Plug 'mlaursen/vim-react-snippets'
Plug 'vim-python/python-syntax'
"Plug 'vim-scripts/indentpython.vim'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'psliwka/vim-smoothie'
Plug 'ludovicchabant/vim-gutentags'
Plug 'antoinemadec/coc-fzf'
Plug 'junegunn/goyo.vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-dispatch'
Plug 'Yggdroot/indentLine'

"Plug 'morhetz/gruvbox'
Plug 'tjdevries/colorbuddy.nvim'
" Plug 'npxbr/gruvbox.nvim'
Plug 'Th3Whit3Wolf/one-nvim'
Plug 'Th3Whit3Wolf/onebuddy'
Plug 'gruvbox-community/gruvbox'
Plug 'ntk148v/vim-horizon'
Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'
Plug 'artanikin/vim-synthwave84'
Plug 'arcticicestudio/nord-vim' 
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/edge'
" Plug 'hzchirs/vim-material'
Plug 'kaicataldo/material.vim', {'branch': 'main'}
Plug 'editorconfig/editorconfig-vim'

"Plug 'ycm-core/YouCompleteMe'

" Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

Plug 'ryanoasis/vim-devicons'

Plug 'ThePrimeagen/vim-be-good'

" presentation
" Plug 'vim-scripts/SyntaxRange'
" Plug 'tybenz/vimdeck'

call plug#end()
" for coc to work with scss files
autocmd FileType scss setl iskeyword+=@-@

"EMMET
let g:user_emmet_mode='a'
let g:user_emmet_leader_key='?'

let g:pymode_lint_config = '$HOME/.pylintrc'
let g:pymode_options_max_line_length=120
let g:ale_linters = {
            \ 'python': ['pylint'],
            \ }
let g:ale_linters_ignore = ['flake8']
let g:ale_python_pylint_change_directory = 0
" disable red space on python by polyglot
let g:python_highlight_space_errors = 0
let g:json_highlight_space_errors = 0
let g:polyglot_disabled = ['jsx']

let g:ale_sign_error = '>>'
let g:ale_sign_warning = '●'

set termguicolors

if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

nnoremap <leader>ee :noh<CR>
inoremap jj <Esc>

"Fix visual indenting
" vmap < <gv
" vmap > >gv
" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv

let g:Schlepp#allowSquishingLines = 1
let g:Schlepp#allowSquishingBlock = 1

let g:gruvbox_italic=1
"let g:onedark_hide_endofbuffer = 1
"let g:onedark_terminal_italics = 1

let g:python_highlight_all=1
let g:UltiSnipsExpandTrigger='<C-j>'

" Black for python
let g:black_linelength=120
"let g:black_virtualenv="/mnt/c/Users/acc/projects__/acubliss/core/.venv/"
nnoremap <leader>bb :Black<CR>
nnoremap <leader>fp :CocPrettier<CR>
nnoremap <leader>fm :Format<CR>

let g:prettier#config#arrow_parens = 'always'
let g:prettier#config#trailing_comma = 'all'
let g:prettier#autoformat = 0
filetype plugin on

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" search tags with this
nmap <silent> <leader>gd g<C-]>

nnoremap <silent> K :call <SID>show_documentation()<CR>

if executable('rg')
    let g:rg_derive_root='true'
endif

"coc explorer stuff
let g:coc_explorer_global_presets = {
            \   '.vim': {
            \     'root-uri': '~/.vim',
            \   },
            \   'tab': {
            \     'position': 'tab',
            \     'quit-on-open': v:true,
            \   },
            \   'floating': {
            \     'position': 'floating',
            \     'open-action-strategy': 'sourceWindow',
            \     'floating-width': 80,
            \     'floating-height': 28,
            \   },
            \   'floatingTop': {
            \     'position': 'floating',
            \     'floating-position': 'center-top',
            \     'open-action-strategy': 'sourceWindow',
            \   },
            \   'floatingLeftside': {
            \     'position': 'floating',
            \     'floating-position': 'left-center',
            \     'floating-width': 50,
            \     'open-action-strategy': 'sourceWindow',
            \   },
            \   'floatingRightside': {
            \     'position': 'floating',
            \     'floating-position': 'right-center',
            \     'floating-width': 50,
            \     'open-action-strategy': 'sourceWindow',
            \   },
            \   'simplify': {
            \     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
            \   }
            \}

" Use preset argument to open it
nmap <space>ce :CocCommand explorer<CR>
nmap <space>qe :CocCommand explorer --preset floating<CR>

let g:netrw_browse_split=2
let g:netrw_banner=0
let g:netrw_winsize=25
nnoremap <leader>me :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

let $FZF_DEFAULT_COMMAND="rg --files --hidden -g '!{.git,node_modules,.env}/*'"

"set grepprg=rg\ --vimgrep\ --smart-case\ --follow

let g:fzf_layout = {'window': { 'width': 0.9, 'height': 0.9 } }
let g:fzf_commits_log_options = '--graph --color=always'
let g:fzf_tags_command = 'ctags -R --exclude=node_modules --exclude=.env --exclude=.git'
" let $FZF_DEFAULT_OPTS="--reverse -m --ansi --preview 'bat -p --color always {}'"
let $FZF_DEFAULT_OPTS = "--reverse -m"

command! -bang -nargs=* Ag call fzf#vim#grep('rg --column --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

nnoremap <leader>cw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>phw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>F :BLines<CR>
nnoremap <leader>an :Snippets<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <leader>ff :Ag<CR>
nnoremap <leader>sf :BLines<CR>

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>cls  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>n  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>p  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>cr  :<C-u>CocListResume<CR>

" Path completion with custom source command
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let test#strategy = "dispatch"
let test#neovim#term_position = "vertical"

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Git
nnoremap <leader>c :Commits<CR>
nnoremap <leader>bc :BCommits<CR>

nnoremap <leader>cs :CocSearch<SPACE>
nnoremap <leader>fs :Files<CR>
nnoremap <leader>s :w!<CR>
nnoremap <leader><CR> :so ~/config/nvim/init.vim<CR>
nnoremap - *zz
nnoremap <leader>t :Tags<CR>


nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>
nnoremap <leader>ps :Rg<SPACE>
noremap <silent> <C-Right> :vertical resize -5<CR>
noremap <silent> <C-Left> :vertical resize +5<CR>
noremap <silent> <C-Up> :resize -1<CR>
noremap <silent> <C-Down> :resize +1<CR>

let g:NERDTreeHijackNetrw=0

let g:indent_guides_start_level=2
let g:indent_guides_guide_size=2

" remap tab navigation
nnoremap <leader>, gT
nnoremap <leader>. gt
nnoremap <leader>w :q!<CR>
nnoremap <Leader>rw :%s/\<<C-r><C-w>\>/
nnoremap <Leader>rr :%s/<C-r><C-w>/

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

" Keep the center
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

hi! Normal ctermbg=NONE guibg=NONE 
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE 

vnoremap <F5> :CarbonNowSh<CR>
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" append result on current expression
nmap <Leader>cc <Plug>(coc-calc-result-append)
" replace result on current expression
nmap <Leader>cr <Plug>(coc-calc-result-replace)

" WSL yank support
" highligts for TreeSitter
hi! link TSKeywordOperator GruvBoxRed

