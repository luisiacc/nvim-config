let g:ale_lint_on_text_changed = 'always'
let g:ale_fix_on_save = 1
let g:ale_fixers = {'javascript': ['prettier', 'eslint'], 'python': ['black', 'isort'], 'rust': ['rustfmt']}
let g:ale_disable_lsp = 1
let g:ale_set_highlights = 0
let g:ale_echo_msg_format = '(%code%) - %s'

let g:ale_linters_explicit = 1
let g:ale_linters = {'javascript': ['prettier', 'eslint'], 'python': ['flake8'], 'rust': ['rls']}
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_enter = 1
