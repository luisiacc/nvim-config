local augroup = vim.api.nvim_create_augroup("ColorschemeChanges", {})

local function extend_hl(group, new_config)
  local current_hl = vim.api.nvim_get_hl_by_name(group, true)
  vim.api.nvim_set_hl(0, group, vim.tbl_extend("force", current_hl, new_config))
end

local function apply_italics()
  local italic_bold_groups = { "TSKeyword", "TSFunction", "TSKeywordFunction", "TSMethod" }
  if vim.g.colors_name == "gruvbox-baby" then
    for _, group in ipairs(italic_bold_groups) do
      extend_hl(group, { italic = true, bold = true })
    end
  else
    for _, group in ipairs(italic_bold_groups) do
      extend_hl(group, { italic = true })
    end
  end
end

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
    apply_italics()
  end,
})
