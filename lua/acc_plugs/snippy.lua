vim.cmd([[imap <expr> <C-,> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<Tab>']])
vim.cmd([[imap <expr> <C-.> snippy#can_expand_or_advance() ? '<Plug>(snippy-expand-or-next)' : '<A-.>']])
vim.cmd([[smap <expr> <C-,> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<Tab>']])
vim.cmd([[smap <expr> <C-.> snippy#can_jump(1) ? '<Plug>(snippy-next)' : '<Tab>']])

require("snippy").setup({
  snippet_dirs = table.concat(vim.api.nvim_list_runtime_paths(), vim.fn.expand("~") .. "/.config/nvim/snippets/"),
})
