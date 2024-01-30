vim.g.vimsyn_embed = "l"
local o = vim.o

vim.g.dracula_italic_comment = true
local c = require("gruvbox-baby.colors").config()
vim.g.gruvbox_baby_highlights = {
  Visual = { bg = "#404040" },
  Pmenu = { fg = c.foreground, bg = c.background_dark },
  PmenuSel = { fg = c.none, bg = "#171717" },
  CmpDocBorder = { fg = c.light_blue, bg = c.none },
  CmpBorder = { fg = c.light_blue, bg = c.none },
  ["@type"] = { fg = c.clean_green, style = "italic" },
  ["@type.builtin"] = { fg = c.blue_gray, style = "italic" },
  ["@type.qualifier"] = { fg = c.orange, style = "italic" },
  ["@type.definition"] = { fg = c.soft_yellow, style = "italic" },
}

vim.g.gruvbox_baby_background_color = "medium"
vim.g.gruvbox_baby_transparent_mode = false
vim.g.gruvbox_baby_transform_colors = false
vim.g.gruvbox_baby_string_style = "nocombine"
vim.g.gruvbox_baby_use_original_palette = false
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_transform_colors = "true"
vim.g.vscode_style = "dark"
vim.g.gruvbox_baby_telescope_theme = 1
vim.g.gruvbox_baby_keyword_style = "NONE"
-- vim.g.gruvbox_baby_function_style = { "italic", "bold" }
vim.g.gruvbox_baby_function_style = { "bold" }

-- " configure nvcode-color-schemes
vim.g.nvcode_termcolors = 256

vim.opt.termguicolors = true
vim.o.background = "light"
vim.cmd([[colorscheme gruvbox-baby]])

-- vim.cmd([[highlight IndentBlanklineContextChar guifg=#365050]])
--
-- vim.cmd([[highlight IndentBlanklineChar guifg=#313131]])
-- vim.cmd([[highlight IndentBlanklineSpaceChar guifg=#313131]])

-- " set background transparent
-- " hi Normal guibg=NONE ctermbg=NONE
-- " hi LineNr ctermbg=NONE guibg=NONE
-- "
--
-- opt.guicursor = "n-v-c:ver70,i:ver25"
-- set cursor to line on insert mode, and vertical 70 on the rest, make it green on normal mode
-- o.guicursor = "n-v-c:ver60,i-ci-ve:ver25,r-cr-o:hor20"
if vim.g.neovide then
  o.guicursor = "n-v-c:block-Cursor,r:hor20-Cursor,i:ver25-Cursor"
end
-- set cursor group green
vim.api.nvim_set_hl(0, "Cursor", { bg = "#00ff00" })
-- red
vim.api.nvim_set_hl(0, "CursorInsert", { bg = "#ff0000" })

local augroup = vim.api.nvim_create_augroup("ChangeCursor", {})
vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  callback = function()
    vim.api.nvim_set_hl(0, "Cursor", { bg = "#00ff00" })
    -- red
    -- vim.api.nvim_set_hl(0, "CursorInsert", { bg = "#ff0000" })
  end,
})
