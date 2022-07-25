local augroup = vim.api.nvim_create_augroup("ColorschemeChanges", {})

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  pattern = "*",
  callback = function()
    require("luisiacc.reset_ts_highlights")()
    local c = require("gruvbox-baby.colors").config()
    local highs = {
      DiffAdd = { bg = c.diff.add },
      DiffChange = { bg = c.diff.change },
      DiffDelete = { bg = c.diff.delete },
      DiffText = { bg = c.diff.text },
    }
    for k, v in pairs(highs) do
      vim.api.nvim_set_hl(0, k, v)
    end
  end,
})
