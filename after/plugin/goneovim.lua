if not vim.g.goneovim then
  return {}
end

vim.g.gui_font_default_size = 12
vim.g.gui_font_face = "LiterationMono Nerd Font"
-- vim.g.gui_font_face = "Liberation Mono"

vim.opt.linespace = 4
vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
