vim.g.vimsyn_embed = "l"

vim.g.dracula_italic_comment = true
local c = require("gruvbox-baby.colors").config()
vim.g.gruvbox_baby_highlights = {
  Visual = { bg = "#404040" },
  Pmenu = { fg = c.comment, bg = c.none },
  PmenuSel = { fg = c.none, bg = "#171717" },
  CmpDocBorder = { fg = c.light_blue, bg = c.none },
  CmpBorder = { fg = c.light_blue, bg = c.none },
}

vim.g.gruvbox_baby_background_color = "soft"
vim.g.gruvbox_baby_transparent_mode = false
vim.g.gruvbox_baby_transform_colors = false
vim.g.gruvbox_baby_string_style = "nocombine"
vim.g.gruvbox_baby_use_original_palette = false
vim.g.tokyonight_style = "night"
vim.g.tokyonight_transform_colors = "true"
vim.g.vscode_style = "dark"
vim.g.gruvbox_baby_telescope_theme = 1
vim.g.gruvbox_baby_keyword_style = "NONE"
vim.g.gruvbox_baby_function_style = { "italic", "bold" }
-- vim.g.gruvbox_baby_function_style = { "bold" }

-- " configure nvcode-color-schemes
vim.g.nvcode_termcolors = 256

vim.opt.termguicolors = true
vim.o.background = "light"
vim.cmd([[colorscheme gruvbox-baby]])
-- " colorscheme nightfly
vim.go.t_Co = 256

vim.g.gruvbox_italic = 1
-- "github theme config
vim.g.github_comment_style = "italic"
vim.g.github_keyword_style = "italic"

-- " hi NormalFloat guifg=NONE ctermfg=223 guibg=#101010 ctermbg=235 gui=NONE cterm=NONE
-- " hi FloatBorder guifg=NONE ctermfg=223 guibg=#101010 ctermbg=235 gui=NONE cterm=NONE

vim.cmd([[highlight IndentBlanklineContextChar guifg=#365050]])

vim.cmd([[highlight IndentBlanklineChar guifg=#313131]])
vim.cmd([[highlight IndentBlanklineSpaceChar guifg=#313131]])

-- " set background transparent
-- " hi Normal guibg=NONE ctermbg=NONE
-- " hi LineNr ctermbg=NONE guibg=NONE
-- "
