set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

let g:python3_host_prog  = '/usr/bin/python3.10'

" syntax off
filetype indent on
filetype plugin on
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
"
" call g:Source('/plugins.vim')

call g:Source('/sets.lua')

call g:Source('/globals.lua')

call g:Source('/commands.vim')
call g:Source('/globals.vim')
call g:Source('/tabline.vim')
call g:Source('/lazyplugins.lua')

lua << EOF
-- require'impatient'.enable_profile()
-- require("acc_plugs.legacy-init")
require("luisiacc.cycle_colorschemes")
require("luisiacc")
require('lightspeed').setup({})
--vim.opt.listchars:append({lead="·"})
-- vim.cmd([[nnoremap <F4> :lua package.loaded.acc_plugs = nil<CR>:source ~/.config/nvim/init.vim<CR>]])
-- vim.api.nvim_del_augroup_by_name("IndentBlanklineAutogroup")
EOF

silent! unmap f
silent! unmap F
silent! unmap t
silent! unmap T

call g:Source('/mappings.vim')
call g:Source('/mappings.lua')
call g:Source('/schemes.lua')

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" let g:neovide_transparency=1
" let g:neovide_cursor_animation_length=0.08
" let g:neovide_cursor_antialiasing=v:true
set laststatus=3

if exists("g:neovide")
    let g:neovide_transparency=0.95
    let g:neovide_cursor_animation_length = 0.05
    let g:neovide_cursor_antialiasing=v:true
    let g:neovide_refresh_rate=60
    let g:neovide_no_idle=v:true
    let g:neovide_scroll_animation_length = 0.12
    let g:neovide_fullscreen=v:false
    " let $NEOVIDE_MULTIGRID = v:true

lua << EOF
vim.g.gui_font_default_size = 10
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "Menlo"

RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s:#h-none",vim.g.gui_font_face, vim.g.gui_font_size)
end


ResizeGuiFont = function(delta)
  vim.g.gui_font_size = vim.g.gui_font_size + delta
  RefreshGuiFont()
end

ResetGuiFont = function()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  RefreshGuiFont()
end


-- change font with commands
local function use_font(font)
  return function()
    vim.g.gui_font_face = font
    vim.opt.guifont = string.format("%s:h%s:#h-none", font, vim.g.gui_font_size)
  end
end

vim.api.nvim_create_user_command("LGM", use_font("MesloLGM NF"), {})
vim.api.nvim_create_user_command("LGL", use_font("MesloLGL NF"), {})

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps

local opts = { noremap = true, silent = true }

vim.keymap.set({'n', 'i'}, "<F7>", function() ResizeGuiFont(1)  end, opts)
vim.keymap.set({'n', 'i'}, "<F6>", function() ResizeGuiFont(-1) end, opts)
EOF
endif
" cool ones
" IBM Plex Mono:h10
" Hack NF:h10
" Fira Code
" SF Mono


