let g:vimsyn_embed = 'l'

let g:tokyonight_style = "storm"

" configure nvcode-color-schemes
let g:nvcode_termcolors=256

set background=dark
colorscheme gruvbox-ts
" colorscheme tokyonight
let g:airline_theme='base16_gruvbox_dark_medium'
" colorscheme material
" let g:material_theme_style='palenight'
" let g:airline_theme = 'material'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#highlighter#highligth = 0
let g:airline#extensions#tabline#fnamemod = ':t'
set t_Co=256

let g:gruvbox_italic=1

hi Normal guisp=#aaa

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

highlight CocFloating guibg=#252525 guifg=#D4879C


"github theme config
let g:github_comment_style = "italic"
let g:github_keyword_style = "italic"


" Airline
func! NvimGps() abort
	return luaeval("require'nvim-gps'.is_available()") ?
		\ luaeval("require'nvim-gps'.get_location()") : ''
endf

let g:airline_section_a = ''
" let g:airline_section_c = airline#section#create(['%{NvimGps()}'])
hi NormalFloat guifg=NONE ctermfg=223 guibg=#101010 ctermbg=235 gui=NONE cterm=NONE
hi FloatBorder guifg=NONE ctermfg=223 guibg=#101010 ctermbg=235 gui=NONE cterm=NONE

" set background transparent
" hi Normal guibg=#151515 ctermbg=NONE
" hi LineNr ctermbg=NONE guibg=#151515
"
