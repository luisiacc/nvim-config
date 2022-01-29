local colorschemes = {
  { name = "gruvbox-baby" },
  { name = "edge", background = "dark" },
  { name = "edge", background = "light" },
  { name = "rose-pine", background = "dark" },
  { name = "rose-pine", background = "light" },
  { name = "github_dimmed" },
  { name = "tokyonight", background = "dark" },
  { name = "tokyonight", background = "light" },
  { name = "gruvbox-material", background = "dark" },
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

  return 0, colorschemes[0]
end

function M.activate_scheme(scheme)
  vim.o.background = scheme.background or "dark"
  vim.cmd(string.format("colorscheme %s", scheme.name))
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
