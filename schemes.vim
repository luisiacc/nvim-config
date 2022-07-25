let g:vimsyn_embed = 'l'

lua << EOF
vim.g.dracula_italic_comment = true
local c = require("gruvbox-baby.colors").config()
vim.g.gruvbox_baby_highlights = {
    Visual = {bg = "#404040"},
    Pmenu = { fg = c.comment, bg = c.none },
    PmenuSel = { fg = c.none, bg = "#171717" },
    CmpDocBorder = { fg = c.light_blue, bg = c.none },
    CmpBorder = { fg = c.light_blue, bg = c.none },
}
EOF

let g:tokyonight_style = "night"
let g:vscode_style = "dark"
let g:gruvbox_baby_telescope_theme = 1
let g:gruvbox_baby_keyword_style = "NONE"

" configure nvcode-color-schemes
let g:nvcode_termcolors=256

set termguicolors
set background=dark
colorscheme gruvbox-baby
" colorscheme nightfly
set t_Co=256

let g:gruvbox_italic=1
"github theme config
let g:github_comment_style = "italic"
let g:github_keyword_style = "italic"


" hi NormalFloat guifg=NONE ctermfg=223 guibg=#101010 ctermbg=235 gui=NONE cterm=NONE
" hi FloatBorder guifg=NONE ctermfg=223 guibg=#101010 ctermbg=235 gui=NONE cterm=NONE

highlight IndentBlanklineContextChar guifg=#365050

highlight IndentBlanklineChar guifg=#313131
highlight IndentBlanklineSpaceChar guifg=#313131

" set background transparent
" hi Normal guibg=NONE ctermbg=NONE
" hi LineNr ctermbg=NONE guibg=NONE
"
