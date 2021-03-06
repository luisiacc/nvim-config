let mapleader=" "

"EMMET
let g:user_emmet_mode='a'
let g:user_emmet_leader_key='?'

let g:ale_python_pylint_executable = 'python'
let g:ale_python_pylint_options = '-m pylint --max-line-length=120'
let g:ale_python_pylint_use_global = 1
let g:pymode_lint_config = '$HOME/.pylintrc'
let g:pymode_options_max_line_length=120
let g:ale_linters = {
            \ 'python': ['pylint'],
            \ }
let g:ale_linters_ignore = ['flake8']
let g:ale_python_pylint_change_directory = 0
" disable red space on python by polyglot
let g:python_highlight_space_errors = 0
let g:json_highlight_space_errors = 0
let g:polyglot_disabled = ['jsx']

let g:ale_sign_error = '>>'
let g:ale_sign_warning = '●'

let g:Schlepp#allowSquishingLines = 1
let g:Schlepp#allowSquishingBlock = 1

let g:UltiSnipsExpandTrigger='<C-j>'

let g:python_highlight_all=1
let g:black_linelength=120

" web stuff
let g:prettier#config#arrow_parens = 'always'
let g:prettier#config#trailing_comma = 'all'
let g:prettier#autoformat = 0

let g:jsx_ext_required=0

let g:closetag_filenames='*.html,*.js,*.jsx,*.tsx'
let g:closetag_regions = { 'typescript': 'jsxRegion,tsxRegion', 'typescriptreact': 'jsxRegion,tsxRegion', 'typescript.tsx': 'jsxRegion,tsxRegion', 'javascript.jsx': 'jsxRegion', 'javascriptreact': 'jsxRegion' }


" sessions
let g:sessions_dir = '~/vim-sessions'
exec 'nnoremap <leader>ms :mks! ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <leader>ss :so ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'

let g:netrw_browse_split=2
let g:netrw_banner=0
let g:netrw_winsize=25

" FZF


if executable('rg')
    let g:rg_derive_root='true'
endif

let $FZF_DEFAULT_COMMAND="rg --files --hidden -g '!{.git,node_modules,.env}/*'"

"set grepprg=rg\ --vimgrep\ --smart-case\ --follow

let g:fzf_layout = {'window': { 'width': 0.9, 'height': 0.9 } }
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_tags_command = 'ctags -R --exclude=node_modules --exclude=.env --exclude=.git'
let $FZF_DEFAULT_OPTS="--reverse -m --ansi --preview 'bat -p --color always {}'"
" let $FZF_DEFAULT_OPTS = "--reverse -m"

" command! -bang -nargs=* Ag call fzf#vim#grep('rg --no-heading --hidden --color=always --smart-case -- '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Ag
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

let test#strategy = "dispatch"
let test#neovim#term_position = "vertical"

let g:NERDTreeHijackNetrw=0

let g:indent_guides_start_level=2
let g:indent_guides_guide_size=2

" let g:indentLine_char_list = ['|', '¦', '┆', '┊'], │, ⎸, or ▏
let g:indentLine_char = '│'

let g:airline_highlighting_cache = 1
let g:airline#extensions#disable_rtp_load = 1
let g:airline_extensions = ['branch', 'tabline']
