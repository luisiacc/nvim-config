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
" highlight TSVariable guifg=#E7D7AD ctermfg=0
highlight TSTag guifg=#8ec07c
highlight TSType guifg=#8ec07c
highlight TSKeyword guifg=#fb4934 ctermfg=0
highlight TSField guifg=#DEDEDE ctermfg=0

highlight ColorColumn ctermbg=45 guibg=#252525
hi MatchParen guibg=#454545

let g:gruvbox_italic=1
"let g:onedark_hide_endofbuffer = 1
"let g:onedark_terminal_italics = 1
"new
"new

hi Normal guisp=#aaa
" set background transparent
" hi Normal guibg=NONE ctermbg=NONE
" hi LineNr ctermbg=NONE guibg=NONE

" A lot of vim colorschemes provide some wild defaults for diff colors. This
" function sets the diff colors to some more sane defaults that at least looks
" quite pleasant in most colorschemes.
function! SaneDiffDefaults()
    hi DiffAdd    ctermfg=234 ctermbg=114 guibg=#26332c guifg=NONE
    hi DiffChange cterm=underline ctermfg=180 guibg=#273842 guifg=NONE
    hi DiffDelete ctermfg=234 ctermbg=168 guibg=#572E33 guifg=#572E33
    hi DiffText   ctermfg=234 ctermbg=180 guibg=#314753 guifg=NONE
    hi! link       diffAdded     DiffAdd
    hi! link       diffChanged   DiffChange
    hi! link       diffRemoved   DiffDelete
    hi! link       diffBDiffer   WarningMsg
    hi! link       diffCommon    WarningMsg
    hi! link       diffDiffer    WarningMsg
    hi! link       diffFile      Directory
    hi! link       diffIdentical WarningMsg
    hi! link       diffIndexLine Number
    hi! link       diffIsA       WarningMsg
    hi! link       diffNoEOL     WarningMsg
    hi! link       diffOnly      WarningMsg
endfunction

call SaneDiffDefaults()
