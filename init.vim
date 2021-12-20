set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

syntax off
filetype indent off
filetype plugin off
" set smartindent
" set autoindent

if has('win32')
    let g:nvim_config_home = '~/AppData/Local/nvim'
else
    let g:nvim_config_home = '~/.config/nvim'
endif

function! g:Source(file)
    exec 'source ' .. g:nvim_config_home .. a:file
endfunction

function! g:Luafile(file)
    exec 'luafile ' .. g:nvim_config_home .. a:file
endfunction

call g:Source('/plugins.vim')
call g:Source('/sets.vim')

call g:Luafile('/globals.lua')

call g:Source('/commands.vim')
call g:Source('/globals.vim')
" call g:Source('/coc-else.vim')
call g:Source('/tabline.vim')

call g:Luafile('/lsp-config.lua')

call g:Source('/schemes.vim')
call g:Source('/mappings.vim')
call g:Source('/windows.vim')

" plugins
call g:Source("/plugins/bqf.lua")
call g:Source("/plugins/copilot.lua")
call g:Source("/plugins/diffview.lua")
call g:Source("/plugins/floaterm.lua")
call g:Source("/plugins/fugitive.lua")
call g:Source("/plugins/gitsigns.lua")
call g:Source("/plugins/hop.lua")
call g:Source("/plugins/indent-blankline.lua")
call g:Source("/plugins/lualine.lua")
call g:Source("/plugins/nvimtree.lua")
call g:Source("/plugins/snippy.lua")
call g:Source("/plugins/telescope.lua")
call g:Source("/plugins/treesitter.lua")
call g:Source("/plugins/vim-test.lua")

lua << EOF
require('nvim-autopairs').setup()
require('spectre').setup()
require("todo-comments").setup({})
require("hop").setup()
--vim.opt.listchars:append({lead="·"})
vim.cmd([[nnoremap <F4> :lua package.loaded.luisiacc = nil<CR>:source ~/.config/nvim/init.vim<CR>]])
EOF

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

set guifont=JetBrainsMono\ Nerd\ Font:h9
set linespace=8
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let g:python_host_prog  = '/usr/bin/python3.9'
" let g:neovide_transparency=1
" let g:neovide_cursor_animation_length=0.08
" let g:neovide_cursor_antialiasing=v:true

