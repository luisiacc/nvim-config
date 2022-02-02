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

call g:Source('/plugins.vim')
"call g:Source('/packer.lua')

call g:Source('/sets.vim')

call g:Source('/globals.lua')

call g:Source('/commands.vim')
call g:Source('/globals.vim')
call g:Source('/tabline.vim')

call g:Source('/mappings.vim')

lua << EOF
-- require'impatient'.enable_profile()
require("acc_plugs")
require'lightspeed'.setup{}
--vim.opt.listchars:append({lead="·"})
vim.cmd([[nnoremap <F4> :lua package.loaded.acc_plugs = nil<CR>:source ~/.config/nvim/init.vim<CR>]])
EOF

call g:Source('/schemes.vim')

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

let g:python3_host_prog  = '/usr/bin/python3.9'
" let g:neovide_transparency=1
" let g:neovide_cursor_animation_length=0.08
" let g:neovide_cursor_antialiasing=v:true

