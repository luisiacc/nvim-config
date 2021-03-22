autocmd FileType lua nnoremap <buffer> <c-f> :call LuaFormat()<cr>
autocmd BufWrite *.lua call LuaFormat()
