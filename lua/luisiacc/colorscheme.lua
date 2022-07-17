function colorscheme(name)
  vim.notify(name)
  vim.cmd("hi clear")
  require("luisiacc.reset_ts_highlights")()
  vim.cmd("colorscheme " .. name)
end

vim.api.nvim_create_user_command("Colorscheme", function(command)
  colorscheme(command.args)
end, { complete = "color", nargs = 1 })
