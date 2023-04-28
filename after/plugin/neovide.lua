if not vim.g.neovide then
  return {}
end

vim.g.neovide_transparency = 0.98
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_refresh_rate = 60
vim.g.neovide_no_idle = true
vim.g.neovide_scroll_animation_length = 0.13
vim.g.neovide_remember_window_size = true
vim.g.neovide_fullscreen = false
vim.env.NEOVIDE_MULTIGRID = true
vim.opt.linespace = 8

vim.g.gui_font_default_size = 12
vim.g.gui_font_size = vim.g.gui_font_default_size
-- vim.g.gui_font_face = "Menlo"
vim.g.gui_font_face = "Liberation Mono"

RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s:#h-none", vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
  vim.opt.linespace = vim.opt.linespace + (delta * 10)
end

ResetGuiFont = function()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps

local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "i" }, "<F7>", function()
  ResizeGuiFont(0.1)
end, opts)
vim.keymap.set({ "n", "i" }, "<F6>", function()
  ResizeGuiFont(-0.1)
end, opts)

--cool ones
--IBM Plex Mono:h10
--Hack NF:h10
--Fira Code
--SF Mono
