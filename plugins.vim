if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set rtp +=~/.vim
call plug#begin('~/.vim/plugged')

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'stsewd/fzf-checkout.vim'
Plug 'fisadev/vim-isort'

Plug 'vim-test/vim-test'
Plug 'pangloss/vim-javascript'
Plug 'hail2u/vim-css3-syntax'

Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'

Plug 'zirrostig/vim-schlepp'
Plug 'jremmen/vim-ripgrep'
Plug 'leafgarland/typescript-vim'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'tweekmonster/django-plus.vim'
Plug 'easymotion/vim-easymotion'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

"Plug 'hardcoreplayers/spaceline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'honza/vim-snippets'
Plug 'mlaursen/vim-react-snippets'
Plug 'vim-python/python-syntax'
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

Plug 'tjdevries/colorbuddy.nvim'
Plug 'Th3Whit3Wolf/one-nvim'
Plug 'Th3Whit3Wolf/onebuddy'
" Plug 'gruvbox-community/gruvbox'
Plug 'ntk148v/vim-horizon'
Plug 'rakr/vim-one'
" Plug 'joshdick/onedark.vim'
Plug 'artanikin/vim-synthwave84'
" Plug 'arcticicestudio/nord-vim' 
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/edge'
Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'kaicataldo/material.vim', {'branch': 'main'}
Plug 'editorconfig/editorconfig-vim'

Plug 'ryanoasis/vim-devicons'

Plug 'ThePrimeagen/vim-be-good'
call plug#end()

" for coc to work with scss files
autocmd FileType scss setl iskeyword+=@-@

if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

