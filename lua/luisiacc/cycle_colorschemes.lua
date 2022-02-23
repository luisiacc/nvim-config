local colorschemes = {
  { name = "gruvbox-baby" },
  { name = "edge" },
  { name = "edge", background = "light" },
  { name = "nightfly" },
  { name = "rose-pine" },
  { name = "rose-pine", background = "light" },
  { name = "github_dimmed" },
  { name = "tokyonight" },
  { name = "tokyonight", background = "light" },
  { name = "gruvbox-material" },
  { name = "everforest" },
  { name = "nord" },
  { name = "kanagawa" },
}

local M = {}

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
  vim.cmd(string.format("colorscheme %s", scheme.name))
  vim.cmd(string.format("set background=" .. bg))
  vim.g.colors_name = scheme.name

  if scheme.name == "rose-pine" then
    if bg == "light" then
      require("rose-pine").set("dawn")
    else
      require("rose-pine").set("moon")
    end
  end

  print(string.format("colorscheme=%s background=%s", scheme.name, bg))
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
end

return M
