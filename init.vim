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

call g:Source('/ale.vim')
call g:Source('/plugins.vim')
call g:Source('/sets.vim')
call g:Source('/lua.vim')
call g:Source('/commands.vim')
call g:Source('/globals.vim')
" call g:Source('/coc-lsp.vim')
call g:Source('/coc-else.vim')
" call g:Source('/coc-explorer.vim')
call g:Source('/nvimtree.vim')

call g:Luafile('/lualine.lua')
call g:Source('/tabline.vim')

call g:Luafile('/lsp-config.lua')
" call g:Source('/compe.vim')
"
" call g:Luafile('/galaxyline.lua')
" call g:Source('/mpbtl.vim')

" call g:Source('/lua-format.vim')
call g:Source('/schemes.vim')
call g:Source('/mappings.vim')
call g:Source('/telescope.vim')
call g:Source('/windows.vim')
call g:Luafile('/diffview.lua')

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

set guifont=SFMono\ Nerd\ Font:h11
set linespace=8
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let g:neovide_transparency=0.95
let g:neovide_cursor_animation_length=0.08

