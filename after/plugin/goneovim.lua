if not vim.g.goneovim then
  return {}
end

vim.g.gui_font_size = 12
vim.g.gui_font_face = "LiterationMono Nerd Font"
-- vim.g.gui_font_face = "Liberation Mono"

vim.opt.linespace = 4
vim.o.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)

ResizeGuiFont = function(delta)
  vim.g.gui_font_size = vim.g.gui_font_size + delta
  vim.opt.linespace = vim.opt.linespace + delta
  vim.o.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
  print(vim.o.guifont)
end

-- Keymaps

local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "i" }, "<F7>", function()
  ResizeGuiFont(1)
end, opts)
vim.keymap.set({ "n", "i" }, "<F6>", function()
  ResizeGuiFont(-1)
end, opts)
