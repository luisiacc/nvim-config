let g:vimsyn_embed = 'l'

let g:tokyonight_style = "storm"
let g:vscode_style = "dark"
let g:gruvbox_baby_telescope_theme = 1

" configure nvcode-color-schemes
let g:nvcode_termcolors=256

set background=dark
colorscheme gruvbox-baby
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
" hi NormalFloat guifg=NONE ctermfg=223 guibg=#101010 ctermbg=235 gui=NONE cterm=NONE
" hi FloatBorder guifg=NONE ctermfg=223 guibg=#101010 ctermbg=235 gui=NONE cterm=NONE

highlight IndentBlanklineContextChar guifg=#365050

highlight IndentBlanklineChar guifg=#313131
highlight IndentBlanklineSpaceChar guifg=#313131

" set background transparent
" hi Normal guibg=NONE ctermbg=NONE
" hi LineNr ctermbg=NONE guibg=NONE
"
