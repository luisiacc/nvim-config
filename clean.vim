set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if has('win32')
    let g:nvim_config_home = '~/AppData/Local/nvim'
else
    let g:nvim_config_home = '~/.config/nvim'
endif

function! g:Source(file)
    exec 'source ' .. g:nvim_config_home .. a:file
endfunction

let b:projects = '/home/acc/projects/'

set rtp +=~/.vim
call plug#begin('~/.vim/plugged')
Plug 'stevearc/dressing.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-project.nvim'
" Plug 'nvim-telescope/telescope-frecency.nvim'
" Plug 'tami5/sqlite.lua'

Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-pack/nvim-spectre'
Plug 'ggandor/lightspeed.nvim'
Plug 'numToStr/Comment.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'windwp/nvim-ts-autotag'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-dispatch'

Plug b:projects .. 'gruvbox-baby'
Plug 'kaiuri/nvim-juliana'
Plug 'catppuccin/nvim', {'as': 'catppuccin', 'do': 'CatppuccinCompile'}
Plug 'akinsho/toggleterm.nvim'

Plug 'folke/tokyonight.nvim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'SmiteshP/nvim-gps'
Plug 'feline-nvim/feline.nvim'
call plug#end()

if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

call g:Source('/sets.lua')
call g:Source('/globals.vim')
call g:Source('/mappings.vim')
call g:Source('/tabline.vim')

lua << EOF
require("acc_plugs.telescope")
require("acc_plugs.toggleterm")
require("acc_plugs.comment")
require("acc_plugs.fugitive")
require("acc_plugs.nvimtree")
require("acc_plugs.gitsigns")
require("acc_plugs.feline")
require("acc_plugs.spectre")
require("acc_plugs.treesitter")
require("luisiacc.colorscheme")
require('lightspeed').setup({})
EOF

colorscheme catppuccin

