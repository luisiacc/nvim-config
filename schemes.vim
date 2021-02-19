hi! Normal ctermbg=NONE guibg=NONE 
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE 

" configure nvcode-color-schemes
let g:nvcode_termcolors=256

let g:airline#extension#ale#enabled = 1
set background=dark
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_invert_selection='0'
colorscheme gruvbox
let g:airline_theme='base16_gruvbox_dark_hard'
" colorscheme material
" let g:material_theme_style='palenight'
" let g:airline_theme = 'material'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#highlighter#highligh = 0
let g:airline#extensions#tabline#fnamemod = ':t'

" highligts for TreeSitter
" hi! link TSKeywordOperator GruvBoxRed
" hi! link TSKeyword GruvBoxRed
"
" gruvbox stuff
highlight TSConstant guifg=#D4879C
highlight TSConstBuiltin guifg=#D4879C
highlight TSVariable guifg=#72A699
highlight TSKeyword guifg=#fb4934
highlight TSField guifg=#DEDEDE

highlight ColorColumn ctermbg=0 guibg=#252525
hi LineNr ctermbg=NONE guibg=NONE

let g:gruvbox_italic=1
"let g:onedark_hide_endofbuffer = 1
"let g:onedark_terminal_italics = 1


