local colorschemes = {
  { name = "gruvbox-baby" },
  { name = "nightfly" },
  { name = "dracula" },
  { name = "one_monokai" },
  { name = "monokai_pro" },
  { name = "monokai_ristretto" },
  { name = "edge" },
  { name = "edge", background = "light" },
  { name = "nightfox" },
  { name = "rose-pine" },
  { name = "rose-pine", background = "light" },
  { name = "github_dimmed" },
  { name = "github_dark" },
  { name = "github_dark_default" },
  { name = "vscode" },
  { name = "tokyonight" },
  { name = "tokyonight", background = "light" },
  { name = "gruvbox-material" },
  { name = "everforest" },
  { name = "kanagawa" },
}

local M = {}

local custom_scheme_setup = {
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
    if scheme.name == current_scheme_name and scheme_background == current_background then
      return i, scheme
    end
  end

  return 1, colorschemes[1]
end

function M.activate_scheme(scheme)
  local bg = scheme.background or "dark"
  print(string.format("colorscheme=%s background=%s", scheme.name, bg))
  vim.o.termguicolors = true
  vim.cmd(string.format("set background=" .. bg))
  vim.cmd(string.format("colorscheme %s", scheme.name))

  if scheme.name == "rose-pine" then
    if bg == "light" then
      require("rose-pine").set("dawn")
    else
      require("rose-pine").set("moon")
    end
  end

  if custom_scheme_setup[scheme] then
    custom_scheme_setup[scheme.name](bg)
  end

  if bg == "dark" then
    custom_scheme_setup["default_dark"](bg)
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

return M
