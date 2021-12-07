if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if has('win32')
    let b:projects = 'C:\projects\'
else
    let b:projects = '/home/acc/projects/'
endif

set rtp +=~/.vim
call plug#begin('~/.vim/plugged')

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'github/copilot.vim'

Plug 'folke/trouble.nvim'

Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'antoinemadec/coc-fzf'
Plug 'andrejlevkovitch/vim-lua-format'
Plug 'kevinhwang91/nvim-bqf'
Plug 'lewis6991/gitsigns.nvim'

"python
" Plug 'fisadev/vim-isort'
Plug 'tweekmonster/django-plus.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'romgrk/nvim-treesitter-context'
Plug 'windwp/nvim-ts-autotag'
Plug 'nvim-treesitter/playground'
Plug 'folke/todo-comments.nvim'
Plug 'SmiteshP/nvim-gps'

Plug 'ray-x/lsp_signature.nvim'
Plug 'tami5/lspsaga.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-calc'
Plug 'onsails/lspkind-nvim'

" Plug 'norcalli/snippets.nvim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" javascript
Plug 'mattn/emmet-vim'
" Plug 'alvan/vim-closetag'
Plug 'windwp/nvim-autopairs'
Plug 'mlaursen/vim-react-snippets'

Plug 'vim-test/vim-test'

" Plug 'dense-analysis/ale'
" Plug 'jremmen/vim-ripgrep'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'phaazon/hop.nvim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'sindrets/diffview.nvim'

Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/goyo.vim'

Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-dispatch'

" Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'skywind3000/asyncrun.vim'

Plug 'tjdevries/colorbuddy.nvim'

Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug b:projects .. 'gruvbox-ts'

Plug 'ntk148v/vim-horizon'
Plug 'rakr/vim-one'
Plug 'sainnhe/edge'
Plug 'kaicataldo/material.vim', {'branch': 'main'}
Plug 'mhartington/oceanic-next'
Plug 'embark-theme/vim', { 'as': 'embark' }
Plug 'mnishz/colorscheme-preview.vim'
Plug 'eddyekofo94/gruvbox-flat.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'projekt0n/github-nvim-theme'
Plug 'lourenci/github-colors'

Plug 'editorconfig/editorconfig-vim'

Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'crispgm/nvim-tabline'
Plug 'hoob3rt/lualine.nvim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

Plug 'mhinz/vim-startify'
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

lua << EOF
require('nvim-autopairs').setup()
EOF
        " section_separators = {'', ''},
        " component_separators = {'', ''}
let g:vim_jsx_pretty_disable_js = 1
let g:vim_jsx_pretty_template_tags = []
let g:vim_jsx_pretty_colorful_config = 0
let g:python_highlight_space_errors = 0
