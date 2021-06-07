command! -nargs=0 CocPrettier :call CocAction('runCommand', 'prettier.formatFile')
command! -nargs=0 FormatDjango :call CocAction('runCommand', 'htmldjango.djhtml.format')

"auto cmd group
augroup vimrc_autocmd
    autocmd!
    " autocmd BufWritePre *.py silent execute ':Black'
    " autocmd VimEnter,VimLeave * silent !tmux set status
    " autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml CocPrettier
    autocmd BufNewFile,BufRead *.vim,*.vimrc setlocal syntax=vim
    autocmd FileType netrw setlocal syntax=netrw
    autocmd BufEnter *.js,*.jsx,*.py silent execute ':setlocal syntax=OFF'
augroup END
