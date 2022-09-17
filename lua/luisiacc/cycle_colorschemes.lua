local colorschemes = {
  { name = "gruvbox-baby", variant = "soft" },
  { name = "gruvbox-baby", variant = "medium" },
  { name = "gruvbox-baby", variant = "dark" },
  { name = "poimandres" },
  { name = "nightfly" },
  { name = "one_monokai" },
  { name = "monokai_pro" },
  { name = "monokai_ristretto" },
  { name = "edge" },
  { name = "edge", background = "light" },
  { name = "nightfox" },
  { name = "rose-pine" },
  { name = "rose-pine", background = "light" },
  { name = "github_dimmed" },
  { name = "github_dark_default" },
  { name = "vscode" },
  { name = "tokyonight" },
  { name = "catppuccin", variant = "frappe" },
  { name = "catppuccin", variant = "macchiato" },
  { name = "handmade-hero-theme" },
}

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
  catppuccin = function(variant)
    vim.cmd(string.format('silent execute "Catppuccin %s"', variant))
  end,
}

local after_colorscheme_hook = {
  poimandres = function()
    local p = require("poimandres.palette")
    local util = require("gruvbox-baby.util")
    local func = util.darken(p.text, 0.85)
    set_hl("TSVariable", { fg = p.text })
    set_hl("TSKeyword", { fg = p.blue3 })
    set_hl("TSInclude", { fg = p.teal1 })
    set_hl("TSField", { fg = p.pink1 })
    set_hl("TSComment", { fg = p.blueGray3 })
    set_hl("TSTag", { fg = p.teal1 })
    set_hl("TSConstant", { fg = p.blue1 })
    set_hl("TSNamedImport", { fg = p.blue2 })

    set_hl("TSFuncLocal", { fg = func })
    set_hl("TSFuncBuiltin", { fg = func })
    set_hl("TSFunction", { fg = func })
    set_hl("TSMethod", { fg = func })

    set_hl("@variable.python", { fg = p.blue3 })
    set_hl("@field.python", { fg = p.blue2 })
    set_hl("@parameter.python", { fg = p.blue2 })
    set_hl("@constant.python", { fg = p.blue2 })
    set_hl("@type.python", { fg = p.blue1 })

    set_hl("TSTag", { fg = p.teal1 })
    set_hl("TSType", { fg = p.blueGray2 })
    set_hl("TSString", { fg = p.teal1 })
    set_hl("@constructor.tsx", { fg = p.teal1 })
    set_hl("TSConstructor", { fg = p.teal1 })
    set_hl("Visual", { bg = p.blueGray3 })
    set_hl("TelescopeSelection", { fg = p.text, bg = p.blueGray3 })
    set_hl("TelescopeSelectionCaret", { fg = p.text, bg = p.blueGray3 })
    set_hl("ColorColumn", { bg = p.background3 })
    set_hl("TSAttribute", { fg = p.blueGray1 })
    set_hl("javascriptTSProperty", { fg = p.blue2 })
    set_hl("typescriptTSProperty", { fg = p.blue2 })
    set_hl("NvimTreeGitIgnored", { fg = p.blueGray3 })
  end,
  one_monokai = function()
    require("one_monokai").setup()
  end,
  ["rose-pine"] = function(bg)
    if bg == "light" then
      require("rose-pine").set("dawn")
    else
      require("rose-pine").set("moon")
    end
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
    vim.cmd([[
      hi IndentBlanklineContextChar guifg=#365050
      hi IndentBlanklineChar guifg=#313131
      hi IndentBlanklineSpaceChar guifg=#313131
    ]])
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

  if bg == "dark" and not (scheme.name == "catppuccin") then
    after_colorscheme_hook["default_dark"](bg)
  end

  vim.defer_fn(function()
    vim.cmd("hi nvim_set_hl_x_hi_clear_bugfix guifg=red")
  end, 100)
end

local _debug = function(content)
  if not content then
    return
  end

  local f = io.open("/home/acc/.nvim.debug.log", "a")
  f:write(vim.inspect(content) .. "\n")
  f.close()
end

--- Move relative the the current scheme
-- @param moves can be a negative number
function M.go_to_scheme(moves)
  local index, _ = M.get_current_scheme()
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

vim.keymap.set("n", "<A-n>", go_backwards)
vim.keymap.set("n", "<A-m>", go_forward)
