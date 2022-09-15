set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

let g:python3_host_prog  = '/usr/bin/python3.10'

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

" lua require("impatient")

let g:smoothie_update_interval = 5
let g:smoothie_speed_linear_factor = 13
let g:smoothie_speed_constant_factor = 13

call g:Source('/plugins.vim')
"call g:Source('/packer.lua')

call g:Source('/sets.lua')

call g:Source('/globals.lua')

call g:Source('/commands.vim')
call g:Source('/globals.vim')
" call g:Source('/tabline.vim')

lua << EOF
-- require'impatient'.enable_profile()
require("acc_plugs")
require("luisiacc.cycle_colorschemes")
require('lightspeed').setup({})
--vim.opt.listchars:append({lead="·"})
-- vim.cmd([[nnoremap <F4> :lua package.loaded.acc_plugs = nil<CR>:source ~/.config/nvim/init.vim<CR>]])
vim.g.neovide_transparency=0.95
vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_cursor_antialiasing=true
vim.g.neovide_refresh_rate=140
vim.g.neovide_no_idle=true
-- vim.api.nvim_del_augroup_by_name("IndentBlanklineAutogroup")
EOF

silent! unmap f
silent! unmap F
silent! unmap t
silent! unmap T

call g:Source('/mappings.vim')
call g:Source('/schemes.lua')

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" let g:neovide_transparency=1
" let g:neovide_cursor_animation_length=0.08
" let g:neovide_cursor_antialiasing=v:true
set laststatus=3
