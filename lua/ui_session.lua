local settings_file = vim.fn.stdpath("config") .. "/saved-session.lua"

local M = {}

function M.save_session_settings()
  local guifont = vim.o.guifont
  local colorscheme = vim.g.colors_name
  local linespace = vim.o.linespace
  -- scale factor is a float
  local scale_factor = vim.g.neovide_scale_factor
	local bg = vim.o.background or "dark"
  local content = string.format(
    'vim.o.guifont="%s"\n'
      .. "vim.cmd[[colorscheme %s]]\n"
      .. "vim.opt.linespace=%d\n"
      .. "vim.opt.background='%s'\n"
      .. "vim.g.neovide_scale_factor=%f\n",
    guifont,
    colorscheme,
    linespace,
		bg,
    scale_factor
  )
  vim.fn.writefile(vim.split(content, "\n"), settings_file)
end

function M.load_session_settings()
  if vim.fn.filereadable(settings_file) == 1 then
    vim.cmd("source " .. settings_file)
  end
end

-- AutoCmds
vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  callback = M.save_session_settings,
})

return M
