vim.cmd([[imap <expr> <A-,> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<Tab>']])
vim.cmd([[imap <expr> <A-.> snippy#can_expand_or_advance() ? '<Plug>(snippy-expand-or-next)' : '<A-.>']])
vim.cmd([[smap <expr> <A-,> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<Tab>']])
vim.cmd([[smap <expr> <A-.> snippy#can_jump(1) ? '<Plug>(snippy-next)' : '<Tab>']])
