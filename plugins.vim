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

lua << EOF
vim.g.autocomplete_tool = "cmp"
vim.g.using_coq = vim.g.autocomplete_tool == "coq"
vim.g.using_cmp = vim.g.autocomplete_tool == "cmp"
EOF

set rtp +=~/.vim
call plug#begin('~/.vim/plugged')

Plug 'mbbill/undotree'
Plug 'stevearc/dressing.nvim'
" Plug 'akinsho/bufferline.nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'tami5/sqlite.lua'
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'github/copilot.vim'

Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lewis6991/gitsigns.nvim'

"python
Plug 'tweekmonster/django-plus.vim'
Plug 'folke/noice.nvim'
Plug 'MunifTanjim/nui.nvim'

Plug 'psliwka/vim-smoothie'
" Plug 'simrat39/symbols-outline.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'romgrk/nvim-treesitter-context'
Plug 'RRethy/nvim-treesitter-endwise'
Plug 'windwp/nvim-ts-autotag'
Plug 'nvim-treesitter/playground'
Plug 'folke/todo-comments.nvim'
Plug 'SmiteshP/nvim-navic'
Plug 'p00f/nvim-ts-rainbow'

" Plug 'glepnir/lspsaga.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'smjonas/inc-rename.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'simrat39/rust-tools.nvim'

" debugger
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'

" debugger langs
Plug 'mfussenegger/nvim-dap-python'

Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'nvim-pack/nvim-spectre'

" Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
" Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}

if g:using_cmp
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-calc'
    Plug 'dcampos/cmp-snippy'
endif

Plug 'dcampos/nvim-snippy'

Plug 'onsails/lspkind-nvim'

Plug 'honza/vim-snippets'

" javascript
" Plug 'mattn/emmet-vim'
Plug 'windwp/nvim-autopairs'

Plug 'vim-test/vim-test'

" Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'ggandor/lightspeed.nvim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'sindrets/diffview.nvim'
Plug 'numToStr/Comment.nvim'

Plug 'ludovicchabant/vim-gutentags'
" Plug 'folke/zen-mode.nvim'

Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-commentary'
Plug 'tpope/vim-markdown'
" Plug 'tpope/vim-dispatch'

" Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'skywind3000/asyncrun.vim'

" Plug 'tjdevries/colorbuddy.nvim'
Plug 'norcalli/nvim-colorizer.lua'

Plug b:projects .. 'gruvbox-baby'
Plug b:projects .. 'the-matrix-theme'
Plug b:projects .. 'github-nvim-theme'
Plug b:projects .. 'handmade-hero-theme.nvim'
Plug 'rktjmp/lush.nvim'

Plug 'briones-gabriel/darcula-solid.nvim'
Plug 'tanvirtin/monokai.nvim'

Plug 'tjdevries/colorbuddy.nvim', { 'branch': 'dev' }
Plug 'jesseleite/nvim-noirbuddy'
" colorschemes
Plug 'arcticicestudio/nord-vim'
Plug 'olivercederborg/poimandres.nvim'
Plug 'kaiuri/nvim-juliana'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
" Plug 'Mofiqul/dracula.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'cpea2506/one_monokai.nvim'
Plug 'sainnhe/edge'
Plug 'bluz71/vim-nightfly-guicolors'
" Plug 'kaicataldo/material.vim', {'branch': 'main'}
" Plug 'embark-theme/vim', { 'as': 'embark' }
Plug 'folke/tokyonight.nvim'
Plug 'Mofiqul/vscode.nvim'
" Plug 'projekt0n/github-nvim-theme'
Plug 'lourenci/github-colors'
Plug 'rose-pine/neovim', {'as': 'rose-pine'}
Plug 'sainnhe/gruvbox-material'
Plug 'yazeed1s/oh-lucy.nvim'
Plug 'tiagovla/tokyodark.nvim'

Plug 'editorconfig/editorconfig-vim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'feline-nvim/feline.nvim'

Plug 'mhinz/vim-startify'
Plug 'akinsho/toggleterm.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'ThePrimeagen/refactoring.nvim'
call plug#end()

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

let g:python_highlight_space_errors = 0

" call g:Source("/plugins/coc-else")

