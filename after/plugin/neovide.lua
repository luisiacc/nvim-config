if not vim.g.neovide then
  return {}
end

vim.g.neovide_floating_blur = 0
vim.g.neovide_transparency = 0.96
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_refresh_rate = 60
vim.g.neovide_no_idle = true
vim.g.neovide_scroll_animation_length = 0.12
vim.g.neovide_input_macos_option_key_is_meta = "only_left"
vim.g.neovide_remember_window_size = true
vim.g.neovide_fullscreen = false
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_scroll_animation_far_lines = 10
vim.env.NEOVIDE_MULTIGRID = true

vim.g.gui_font_default_size = 12
vim.g.gui_font_size = vim.g.gui_font_default_size
-- vim.opt.linespace = 0
-- vim.g.gui_font_face = "IntelOne Mono"
vim.opt.linespace = 12
vim.g.gui_font_face = "Operator Mono"

RefreshGuiFont = function(opts)
  -- vim.opt.guifont = string.format("%s:h%s:#h-none", vim.g.gui_font_face, vim.g.gui_font_size)
  local font = "%s:h%s"
  if opts and opts.h then
    font = font .. ":#h-" .. opts.h
  end
	if opts and not opts.h then
		font = font .. ":#h-none"
	end

  if opts and opts.e then
    font = font .. ":#e-" .. opts.e
  end
  if opts and opts.w then
    font = font .. ":W" .. opts.w
  end
  vim.opt.guifont = string.format(font, vim.g.gui_font_face, vim.g.gui_font_size)
end

local function startswith(str, start)
  return string.sub(str, 1, string.len(start)) == start
end

local function findIndex(tbl, value)
  for i, v in ipairs(tbl) do
    if startswith(value, v.name) then
      return i
    end
  end
  return 1
end

local fonts = {
  { name = "Dank Mono" },
  { name = "Droid Sans Mono" },
  { name = "Liberation Mono", h = "none", e = "antialias" },
  { name = "Operator Mono", w = "300" },
  { name = "Menlo" },
  { name = "Fira Code", h = "none" },
  { name = "SF Mono" },
  { name = "Geist Mono" },
  -- { name = "Segoe UI Mono W01", h = "none" },
}

ResizeGuiFont = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
  vim.o.linespace = vim.o.linespace + (delta * 20)
end

ResetGuiFont = function()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  local fontIndex = findIndex(fonts, vim.g.gui_font_face)
  RefreshGuiFont(fonts[fontIndex])
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

local function moveFont(move)
  local current_font = vim.opt.guifont:get()[1]
  local current_font_index = findIndex(fonts, current_font)
  print("current ", current_font_index, current_font)
  local new_index = ((current_font_index + move - 1) % #fonts) + 1
  if new_index == 0 then
    new_index = #fonts
  end
  vim.g.gui_font_face = fonts[new_index].name
  RefreshGuiFont(fonts[new_index])
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
-- vim.opt.guicursor = "n-v-c:block,r:hor20,i:ver25"
vim.opt.guicursor = "n-v-c:ver60,i-ci-ve:ver25,r-cr-o:hor20"
-- set cursor group green
vim.api.nvim_set_hl(0, "Cursor", { bg = "#00ff00" })
-- red
vim.api.nvim_set_hl(0, "CursorInsert", { bg = "#ff0000" })
