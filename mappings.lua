vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "//", 'y/<C-R>"<CR>')

vim.keymap.set('i', '<A-a>', 'á', {noremap = true, silent = true})
vim.keymap.set('i', '<A-e>', 'é', {noremap = true, silent = true})
vim.keymap.set('i', '<A-i>', 'í', {noremap = true, silent = true})
vim.keymap.set('i', '<A-o>', 'ó', {noremap = true, silent = true})
vim.keymap.set('i', '<A-u>', 'ú', {noremap = true, silent = true})
vim.keymap.set('i', '<A-n>', 'ñ', {noremap = true, silent = true})

vim.keymap.set("n", 'j', 'gj', {noremap = true, silent = true})
vim.keymap.set("n", 'k', 'gk', {noremap = true, silent = true})
vim.keymap.set("n", 'H', '^', {noremap = true, silent = true})
vim.keymap.set("n", 'L', '$', {noremap = true, silent = true})

vim.api.nvim_create_user_command("CopyRelPath", function() vim.api.nvim_call_function("setreg", {"+", vim.fn.fnamemodify(vim.fn.expand("%"), ":.")}) end, {})
vim.keymap.set("n", "<leader>cm", ":CopyRelPath<CR>", {noremap = true, silent = true})

vim.keymap.set("n", "<leader>an", "acA")

-- Increase panel width
vim.keymap.set("n", "<C-f>", ":vertical resize +5<CR>", {noremap = true, silent = true})
-- Decrease panel width
vim.keymap.set("n", "<C-e>", ":vertical resize -5<CR>", {noremap = true, silent = true})
