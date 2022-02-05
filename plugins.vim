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
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" Plug 'github/copilot.vim'

Plug 'folke/trouble.nvim'

Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'stsewd/fzf-checkout.vim'
" Plug 'antoinemadec/coc-fzf'
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
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'nvim-pack/nvim-spectre'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-calc'
" Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'dcampos/nvim-snippy'
Plug 'dcampos/cmp-snippy'

Plug 'onsails/lspkind-nvim'

" Plug 'norcalli/snippets.nvim'
" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" javascript
Plug 'mattn/emmet-vim'
" Plug 'alvan/vim-closetag'
Plug 'windwp/nvim-autopairs'
" Plug 'mlaursen/vim-react-snippets'

Plug 'vim-test/vim-test'

" Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'ggandor/lightspeed.nvim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'sindrets/diffview.nvim'
Plug 'numToStr/Comment.nvim'

Plug 'ludovicchabant/vim-gutentags'
Plug 'folke/zen-mode.nvim'

Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-commentary'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-dispatch'

" Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'skywind3000/asyncrun.vim'

Plug 'tjdevries/colorbuddy.nvim'
Plug 'norcalli/nvim-colorizer.lua'

Plug b:projects .. 'gruvbox-baby'
Plug 'sainnhe/gruvbox-material'
Plug 'rktjmp/lush.nvim'
Plug 'arcticicestudio/nord-vim'

" Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'ntk148v/vim-horizon'
Plug 'sainnhe/edge'
Plug 'kaicataldo/material.vim', {'branch': 'main'}
Plug 'embark-theme/vim', { 'as': 'embark' }
Plug 'folke/tokyonight.nvim'
Plug 'sainnhe/everforest'
Plug 'projekt0n/github-nvim-theme'
Plug 'rebelot/kanagawa.nvim'
Plug 'FrenzyExists/aquarium-vim'
Plug 'rose-pine/neovim', {'as': 'rose-pine'}

Plug 'editorconfig/editorconfig-vim'

" Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'crispgm/nvim-tabline'
Plug 'hoob3rt/lualine.nvim'
" Plug 'kdheepak/tabline.nvim'

Plug 'mhinz/vim-startify'
Plug 'voldikss/vim-floaterm'
Plug 'ThePrimeagen/harpoon'
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

let g:vim_jsx_pretty_disable_js = 1
let g:vim_jsx_pretty_template_tags = []
let g:vim_jsx_pretty_colorful_config = 0
let g:python_highlight_space_errors = 0

" call g:Source("/plugins/coc-else")

