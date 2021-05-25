if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set rtp +=~/.vim
call plug#begin('~/.vim/plugged')

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'antoinemadec/coc-fzf'
Plug 'liuchengxu/vista.vim'
Plug 'andrejlevkovitch/vim-lua-format'
Plug 'kevinhwang91/nvim-bqf'

"python
Plug 'fisadev/vim-isort'
" Plug 'brentyi/isort.vim'
Plug 'tweekmonster/django-plus.vim'
" Plug 'vim-python/python-syntax'
" Plug 'psf/black', { 'branch': 'stable' }

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'norcalli/snippets.nvim'
" Plug 'p00f/nvim-ts-rainbow'

" javascript
" Plug 'maxmellon/vim-jsx-pretty'
" Plug 'pangloss/vim-javascript'
Plug 'hail2u/vim-css3-syntax'
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'
" Plug 'jiangmiao/auto-pairs'
Plug 'windwp/nvim-autopairs'
Plug 'leafgarland/typescript-vim'
Plug 'mlaursen/vim-react-snippets'

Plug 'vim-test/vim-test'

Plug 'dense-analysis/ale'
Plug 'jremmen/vim-ripgrep'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'easymotion/vim-easymotion'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'sindrets/diffview.nvim'

Plug 'honza/vim-snippets'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/goyo.vim'

Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-dispatch'
Plug 'Yggdroot/indentLine'

Plug 'tjdevries/colorbuddy.nvim'
Plug 'Th3Whit3Wolf/one-nvim'
Plug 'Th3Whit3Wolf/onebuddy'
" Plug 'gruvbox-community/gruvbox'
Plug 'ntk148v/vim-horizon'
Plug 'rakr/vim-one'
" Plug 'joshdick/onedark.vim'
" Plug 'artanikin/vim-synthwave84'
" Plug 'arcticicestudio/nord-vim' 
" Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/edge'
Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'kaicataldo/material.vim', {'branch': 'main'}
Plug 'mhartington/oceanic-next'
Plug 'embark-theme/vim', { 'as': 'embark' }

Plug 'editorconfig/editorconfig-vim'

Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
" Plug 'akinsho/nvim-bufferline.lua'
" Plug 'romgrk/barbar.nvim'
" Plug 'kyazdani42/nvim-tree.lua'
" Plug 'bagrat/vim-buffet'
Plug 'crispgm/nvim-tabline'
Plug 'hoob3rt/lualine.nvim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'itchyny/lightline.vim'
" Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
" Plug 'Iron-E/nvim-highlite'

Plug 'mhinz/vim-startify'
Plug 'ThePrimeagen/vim-be-good'
Plug 'voldikss/vim-floaterm'
Plug 'AndrewRadev/tagalong.vim'
call plug#end()

" for coc to work with scss files
autocmd FileType scss setl iskeyword+=@-@

if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

" Just set :DB w:db = mysql://user:pass@host/dbname<CR>, write your query, and run the current buffer with :DB<CR>.

" What makes it really nice, is that the :DB<CR> command supports visual selections, meaning you can have many queries in the same buffer, select the one you want to execute and do :DB<CR>.

" I added a mapping: vmap <Leader>D :DB<CR> that allows me to just tap <Space>D to run the visually selected query.

" :lua << EOF
"     require'bufferline'.setup{
"         options = {
"             show_tab_indicators = true,
"             enforce_regular_tabs = true,
"             always_show_bufferline = true
"         }
"     }
" EOF

" require('lualine').setup{
"     options = {
"         theme = 'gruvbox',
"         section_separators = {'', ''},
"         component_separators = {'', ''}
"     }
" }
" require'tabline'.setup{}

luafile ~/.config/nvim/lualine.lua
source ~/.config/nvim/tabline.vim

lua << EOF
require('nvim-autopairs').setup()
EOF
        " section_separators = {'', ''},
        " component_separators = {'', ''}
let g:vim_jsx_pretty_disable_js = 1
let g:vim_jsx_pretty_template_tags = []
let g:vim_jsx_pretty_colorful_config = 0
let g:python_highlight_space_errors = 0
