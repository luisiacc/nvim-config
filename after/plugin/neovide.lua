if not vim.g.neovide then
  return {}
end

vim.g.neovide_floating_blur = 0
vim.g.neovide_transparency = 0.96
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_refresh_rate = 60
vim.g.neovide_no_idle = true
vim.g.neovide_scroll_animation_length = 0.13
vim.g.neovide_input_macos_alt_is_meta = true
vim.g.neovide_remember_window_size = true
vim.g.neovide_fullscreen = false
vim.env.NEOVIDE_MULTIGRID = true

vim.g.gui_font_default_size = 12
vim.g.gui_font_size = vim.g.gui_font_default_size
-- vim.opt.linespace = 0
-- vim.g.gui_font_face = "IntelOne Mono"
vim.opt.linespace = 12
vim.g.gui_font_face = "Operator Mono"

RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s:#h-none", vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
  vim.o.linespace = vim.o.linespace + (delta * 20)
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
vim.keymap.set({ "n", "i" }, "<F8>", function()
  if vim.g.neovide_transparency == 1 then
    vim.g.neovide_transparency = 0.96
  else
    vim.g.neovide_transparency = 1
  end
end, opts)

function startswith(str, start)
  return string.sub(str, 1, string.len(start)) == start
end

local function findIndex(tbl, value)
  for i, v in ipairs(tbl) do
    if startswith(value, v) then
      return i
    end
  end
  return 1
end

local fonts = {
  "Dank Mono",
  "Liberation Mono",
  "Operator Mono",
  "Menlo",
  "Zed Mono",
  "SF Mono",
  "Geist Mono",
}

local function moveFont(move)
  local current_font = vim.opt.guifont:get()[1]
  local current_font_index = findIndex(fonts, current_font)
  print("current ", current_font_index, current_font)
  local new_index = ((current_font_index + move - 1) % #fonts) + 1
  if new_index == 0 then
    new_index = #fonts
  end
  vim.g.gui_font_face = fonts[new_index]
  RefreshGuiFont()
end
vim.keymap.set({ "n", "i" }, "<F5>", function()
  moveFont(1)
end, opts)
vim.keymap.set({ "n", "i" }, "<F4>", function()
  moveFont(-1)
end, opts)

--cool ones
--IBM Plex Mono:h10
--Hack NF:h10
--Fira Code
--SF Mono

-- Enable cursor line highlighting
vim.cmd("set cursorline")

-- Set the cursor line highlighting color (Light Salmon)
vim.cmd("highlight CursorLine cterm=NONE ctermbg=33 guibg=#FFA07A")

-- Set the cursor shape in normal, insert, and replace modes (Light Salmon)
vim.opt.guicursor = "n-v-c:block,r:hor20,i:ver25"
