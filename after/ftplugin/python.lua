vim.opt_local.autoindent = true
vim.opt_local.cindent = true
vim.opt_local.copyindent = true
vim.opt_local.expandtab = true
vim.opt_local.smartindent = true
vim.opt_local.shiftwidth = 4
vim.opt_local.smarttab = true
vim.opt_local.softtabstop = 4
vim.opt_local.tabstop = 4

vim.keymap.set('n', '<c-u>', 'ywoprint("<esc>pi", <esc>pi)<esc>', { noremap = true, silent = true })
