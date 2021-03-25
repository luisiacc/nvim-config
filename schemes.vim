" hi! Normal ctermbg=NONE guibg=NONE 
" hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE 

" lightline
" let g:lightline = {
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'filename', "modified" ] ]
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'FugitiveStatusline'
"       \ },
"       \ }
" autocmd VimEnter * call SetupLightlineColors()
" function SetupLightlineColors() abort
"   " transparent background in statusbar
"   let l:palette = lightline#palette()

"   let l:palette.normal.middle = [ [ '#313131', '#303030', '256', '1' ] ]
"   let l:palette.inactive.middle = l:palette.normal.middle
"   let l:palette.tabline.middle = l:palette.normal.middle

"   call lightline#colorscheme()
" endfunction


" configure nvcode-color-schemes
let g:nvcode_termcolors=256

let g:airline#extension#ale#enabled = 1
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_invert_selection='0'
set background=dark
colorscheme gruvbox
let g:airline_theme='base16_gruvbox_dark_hard'
" colorscheme material
" let g:material_theme_style='palenight'
" let g:airline_theme = 'material'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#highlighter#highligth = 0
let g:airline#extensions#tabline#fnamemod = ':t'
set t_Co=256

" highligts for TreeSitter
" hi! link TSKeywordOperator GruvBoxRed
" hi! link TSKeyword GruvBoxRed
"
" gruvbox stuff
highlight TSConstant guifg=#D4879C ctermfg=0 gui=bold cterm=bold
highlight TSConstBuiltin guifg=#D4879C ctermfg=0
highlight TSVariable guifg=#72A699 ctermfg=0
highlight TSTag guifg=#8ec07c
highlight TSType guifg=#8ec07c
highlight TSKeyword guifg=#fb4934 ctermfg=0
highlight TSField guifg=#DEDEDE ctermfg=0

highlight DiffAdd guifg=#082708 guibg=#284230
highlight DiffDelete guifg=#472d2d guibg=#472d2d
highlight DiffText guifg=#202020 guibg=#776D19
highlight DiffChange guifg=#AC9D25

highlight ColorColumn ctermbg=45 guibg=#252525
hi MatchParen guibg=#454545

let g:gruvbox_italic=1
"let g:onedark_hide_endofbuffer = 1
"let g:onedark_terminal_italics = 1
"new
"new

" set background transparent
" hi Normal guibg=#252525 ctermbg=NONE
" hi LineNr ctermbg=NONE guibg=#252525

