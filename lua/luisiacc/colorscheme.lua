local augroup = vim.api.nvim_create_augroup("ColorschemeChanges", {})

local function extend_hl(group, new_config)
  local current_hl = vim.api.nvim_get_hl_by_name(group, true)
  vim.api.nvim_set_hl(0, group, vim.tbl_extend("force", current_hl, new_config))
end

local M = {}
function M.cmpitems()
  local highlights = {
    PmenuSel = { bg = "#282C34", fg = "NONE" },
    Pmenu = { fg = "#C5CDD9", bg = "#22252A" },

    CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", fmt = "strikethrough" },
    CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", fmt = "bold" },
    CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", fmt = "bold" },
    CmpItemMenu = { fg = "#C792EA", bg = "NONE", fmt = "italic" },

    CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
    CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
    CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },

    CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
    CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
    CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },

    CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
    CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
    CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },

    CmpItemKindFunction = { fg = "#EADFF0", bg = "#A377BF" },
    CmpItemKindStruct = { fg = "#EADFF0", bg = "#A377BF" },
    CmpItemKindClass = { fg = "#EADFF0", bg = "#A377BF" },
    CmpItemKindModule = { fg = "#EADFF0", bg = "#A377BF" },
    CmpItemKindOperator = { fg = "#EADFF0", bg = "#A377BF" },

    CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
    CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },

    CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
    CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
    CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A959" },

    CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
    CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
    CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },

    CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
    CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
    CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
  }

  for k, v in pairs(highlights) do
    print(k,v)
    vim.api.nvim_set_hl(0, k, v)
  end
end

local function apply_italics()
  local italic_bold_groups = { "TSKeyword", "TSFunction", "TSKeywordFunction", "TSMethod", "TSInclude" }
  if vim.g.colors_name == "gruvbox-baby" then
    for _, group in ipairs(italic_bold_groups) do
      extend_hl(group, { italic = true })
    end
    extend_hl("TSFunction", { italic = true, bold = true })
    extend_hl("TSMethod", { italic = true, bold = true })
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
    -- require("luisiacc.reset_ts_highlights")()
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
    print("doingit")
    -- apply_italics()
  end,
})
return M
