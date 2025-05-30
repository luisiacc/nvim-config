local utils = require("gruvbox-baby.util")
local colorschemes = {
  { name = "gruvbox-baby", variant = "medium" },
  { name = "gruvbox-baby", variant = "dark" },
  { name = "poimandres" },
  { name = "rose-pine" },
  { name = "monokai_pro" },
  { name = "monokai_ristretto" },
  { name = "duskfox" },
  { name = "vscode" },
  { name = "github_dark_dimmed" },
  { name = "tokyonight" },
  { name = "catppuccin" },
  { name = "thematrix" },
  { name = "handmade-hero-theme" },
}

local function get_hl(group, attr)
  local normal_group = vim.fn.hlID(group)
  return vim.fn.synIDattr(normal_group, attr)
end

local function extend_hl(group, new_config)
  local current_hl = vim.api.nvim_get_hl_by_name(group, true)
  vim.api.nvim_set_hl(0, group, vim.tbl_extend("force", current_hl, new_config))
end

local function set_hl(group, config)
  vim.api.nvim_set_hl(0, group, config)
end

local M = {}

local pre_colorscheme_hook = {
  ["gruvbox-baby"] = function(variant)
    vim.g.gruvbox_baby_background_color = variant
  end,
}

local after_colorscheme_hook = {
  monokai_pro = function()
    extend_hl("@function.call", { link = "@function" })
    extend_hl("@method.call", { link = "@function" })
  end,
  monokai_ristretto = function()
    extend_hl("@function.call", { link = "@function" })
    extend_hl("@method.call", { link = "@function" })
  end,
  dracula = function(bg)
    vim.cmd([[hi Comment guifg=#665c54 gui=italic ]])
    vim.cmd([[hi TSComment guifg=#665c54 gui=italic ]])
  end,
  nightfox = function(bg)
    require("nightfox").setup({
      options = {
        styles = {
          functions = "bold,italic",
        },
      },
    })
  end,
  mariana = function(bg)
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#515151" })
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#515151" })
    extend_hl("TabLine", { underline = false })
  end,
  default_dark = function(bg)
    vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#365050" })
  end,
  poimandres = function(bg)
    vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#101010", nocombine = true })
    vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2a2f3f", bg = "none", nocombine = true })
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#2a2f3f", nocombine = true })
    vim.api.nvim_set_hl(0, "StatusColumn", { bg = "#2a2f3f", nocombine = true })
  end,
}

-- @returns the current scheme from the list above, along with it's index
function M.get_current_scheme()
  local current_scheme_name = vim.g.colors_name
  local current_background = vim.o.background or "dark"

  for i, scheme in ipairs(colorschemes) do
    local scheme_background = scheme.background or "dark"
    if
      scheme.name == current_scheme_name
      and scheme_background == current_background
      and (not vim.g.cycle_colorschemes_variant or vim.g.cycle_colorschemes_variant == scheme.variant)
    then
      return i, scheme
    end
  end
  return 1, colorschemes[1]
end

function M.activate_scheme(scheme)
  local bg = scheme.background or "dark"
  print(string.format("colorscheme=%s background=%s", scheme.name, bg))
  vim.o.termguicolors = true

  vim.g.cycle_colorschemes_variant = nil
  if pre_colorscheme_hook[scheme.name] and scheme.variant then
    vim.g.cycle_colorschemes_variant = scheme.variant
    pre_colorscheme_hook[scheme.name](scheme.variant)
  end

  vim.cmd(string.format("set background=" .. bg))
  vim.cmd(string.format("colorscheme %s", scheme.name))

  if after_colorscheme_hook[scheme.name] then
    after_colorscheme_hook[scheme.name](bg)
  end

  if bg == "dark" and not (scheme.name ~= "catppuccin") then
    after_colorscheme_hook["default_dark"](bg)
  end

  vim.defer_fn(function()
    vim.cmd("hi nvim_set_hl_x_hi_clear_bugfix guifg=red")
  end, 100)
  vim.cmd("IBLToggle") -- toggle on and off
  vim.cmd("IBLToggle")
end

local _debug = function(content)
  if not content then
    return
  end

  local f = io.open("/Users/Luis/.nvim.debug.log", "a")
  f:write(vim.inspect(content) .. "\n")
  f.close()
end

--- Move relative the the current scheme
-- @param moves can be a negative number
function M.go_to_scheme(moves)
  local index, _ = M.get_current_scheme()
  print("current scheme=" .. colorschemes[index].name)
  local new_index = ((index + moves - 1) % #colorschemes) + 1
  local next_scheme = colorschemes[new_index]
  pcall(M.activate_scheme, next_scheme)
  vim.opt.laststatus = 3
end

local function go_forward()
  M.go_to_scheme(1)
end

local function go_backwards()
  M.go_to_scheme(-1)
end

vim.keymap.set("n", "<leader>y", go_backwards)
vim.keymap.set("n", "<leader>h", go_forward)
