-- vim.cmd([[nnoremap <leader>h :lua require("harpoon.ui").toggle_quick_menu()<CR>]])
vim.keymap.set("n", "<C-S-h>", require("harpoon.ui").toggle_quick_menu, { silent = true })
vim.keymap.set("n", "<C-S-a>", require("harpoon.mark").toggle_file, { silent = true })
vim.keymap.set("n", "<C-S-o>", require("harpoon.ui").nav_prev, { silent = true })
vim.keymap.set("n", "<C-S-p>", require("harpoon.ui").nav_next, { silent = true })

local go = function(v)
  return function()
    require("harpoon.ui").nav_file(v, { goto_if_open = true })
  end
end

vim.keymap.set("n", "<C-S-1>", go(1), { silent = true })
vim.keymap.set("n", "<C-S-2>", go(2), { silent = true })
vim.keymap.set("n", "<C-S-3>", go(3), { silent = true })
vim.keymap.set("n", "<C-S-4>", go(4), { silent = true })
vim.keymap.set("n", "<C-S-5>", go(5), { silent = true })
vim.keymap.set("n", "<C-S-6>", go(6), { silent = true })
vim.keymap.set("n", "<C-S-7>", go(7), { silent = true })
