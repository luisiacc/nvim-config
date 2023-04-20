vim.cmd([[imap <expr> <C-,> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<C-,>']])
-- vim.cmd([[imap <expr> <C-.> snippy#can_expand_or_advance() ? '<Plug>(snippy-expand-or-next)' : '<C-.>']])
vim.cmd([[smap <expr> <C-,> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<C-,>']])
vim.cmd([[smap <expr> <C-.> snippy#can_jump(1) ? '<Plug>(snippy-next)' : '<C-.>']])
vim.cmd([[xmap <C-.> <Plug>(snippy-cut-text)]])
vim.cmd([[imap <expr> <C-.> snippy#can_expand() ? '<Plug>(snippy-expand)' : '<C-.>']])

require("snippy").setup({
  snippet_dirs = table.concat(vim.api.nvim_list_runtime_paths(), "/Users/Luis/.config/nvim/snippets/"),
  mappings = {
    is = {
      ["<C-.>"] = "expand_or_advance",
      ["<C-,>"] = "previous",
    },
  },
})
