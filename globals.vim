let mapleader=" "

"EMMET
let g:user_emmet_mode='a'
let g:user_emmet_leader_key='?'

let g:pymode_lint_config = '$HOME/.pylintrc'
let g:pymode_options_max_line_length=120

" sessions
let g:sessions_dir = '~/vim-sessions'
exec 'nnoremap <leader>ms :mks! ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <leader>ss :so ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'

if executable('rg')
    let g:rg_derive_root='true'
endif

let $FZF_DEFAULT_COMMAND="rg --files --hidden -g '!{.git,node_modules,.env}/*'"

"set grepprg=rg\ --vimgrep\ --smart-case\ --follow

let g:fzf_layout = {'window': { 'width': 0.9, 'height': 0.9 } }
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_tags_command = 'ctags -R --exclude=node_modules --exclude=.env --exclude=.git'
let $FZF_DEFAULT_OPTS="--reverse -m --ansi"
" let $FZF_DEFAULT_OPTS = "--reverse -m"

" command! -bang -nargs=* Ag call fzf#vim#grep('rg --no-heading --hidden --color=always --smart-case -- '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Ag
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \    fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

let test#strategy = "asyncrun_background_term"
let test#neovim#term_position = "vertical"

let g:indent_guides_start_level=2
let g:indent_guides_guide_size=2

" let g:indentLine_char_list = ['|', '¦', '┆', '┊'], │, ⎸, or ▏
" let g:indent_blankline_char = '│'


