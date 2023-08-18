local vi_mode_utils = require("feline.providers.vi_mode")
local c = require("gruvbox-baby.colors").config()

local M = {
  statusline = {
    icons = {
      active = {},
      inactive = {},
    },
    noicons = {
      active = {},
      inactive = {},
    },
  },
  winbar = {
    icons = {
      active = {},
      inactive = {},
    },
    noicons = {
      active = {},
      inactive = {},
    },
  },
}

local file_color = c.soft_yellow

local theme = {
  yellow = file_color,
  normal = c.foreground,
  bg = c.background_dark,
  fg = "#D0D0D0",
  black = "#454545",
  skyblue = "#50B0F0",
  cyan = "#009090",
  green = "#60A040",
  oceanblue = "#0066cc",
  magenta = "#C26BDB",
  orange = "#FF9000",
  red = "#D10000",
  violet = "#9E93E8",
  white = "#FFFFFF",
}

-- 
local gps = require("nvim-navic")
M.statusline.icons.active[1] = {
  {
    provider = "▊ ",
    hl = {
      fg = "yellow",
    },
  },
  {
    provider = "vi_mode",
    hl = function()
      return {
        name = vi_mode_utils.get_mode_highlight_name(),
        fg = vi_mode_utils.get_mode_color(),
        style = "bold",
      }
    end,
  },
  {
    provider = "file_info",
    hl = {
      bg = "bg",
      fg = "yellow",
      style = "bold",
    },
    left_sep = { str = "    ", hl = { fg = "black" } },
    right_sep = { str = "    ", hl = { fg = "black" } },
  },
  {
    provider = "file_size",
  },
  {
    provider = "position",
    hl = {
      fg = "yellow",
      style = "bold",
    },
    left_sep = { str = "    ", hl = { fg = "black" } },
    right_sep = { str = "    ", hl = { fg = "black" } },
  },
  {
    provider = "diagnostic_errors",
    hl = { fg = "red" },
    right_sep = { str = "    ", hl = { fg = "black" } },
  },
}

M.statusline.icons.active[2] = {
  {
    provider = "git_branch",
    hl = {
      fg = "violet",
      bg = "bg",
      style = "bold",
    },
    right_sep = {
      str = " ",
      hl = {
        fg = "NONE",
        bg = "black",
      },
    },
  },
  {
    provider = "line_percentage",
    hl = {
      style = "bold",
    },
    left_sep = "  ",
    right_sep = " ",
  },
}

M.statusline.icons.inactive[1] = {
  {
    provider = "file_type",
    hl = {
      fg = "white",
      bg = "oceanblue",
      style = "bold",
    },
    left_sep = {
      str = " ",
      hl = {
        fg = "NONE",
        bg = "oceanblue",
      },
    },
    right_sep = {
      {
        str = " ",
        hl = {
          fg = "NONE",
          bg = "oceanblue",
        },
      },
      "slant_right",
    },
  },
  -- Empty component to fix the highlight till the end of the statusline
  {},
}

M.winbar.icons.active[1] = {
  {
    provider = "file_info",
    hl = {
      fg = "skyblue",
      bg = "NONE",
      style = "bold",
    },
  },
  -- {
  --   provider = function()
  --     return gps.get_location()
  --   end,
  --   hl = { fg = "skyblue", bg = "NONE", style = "bold" },
  --   enabled = function()
  --     return gps.is_available()
  --   end,
  --   left_sep = {
  --     { str = " ❯ ", hl = { bg = "NONE", fg = "skyblue" } },
  --   },
  -- },
}

M.winbar.icons.inactive[1] = {
  {
    provider = "file_info",
    hl = {
      fg = "white",
      bg = "NONE",
      style = "bold",
    },
  },
}

require("feline").setup({ components = M.statusline.icons })
require("feline").winbar.setup({ components = M.winbar.icons })
require("feline").use_theme(theme)

local function get_hl(group, attr)
  local normal_group = vim.fn.hlID(group)
  return vim.fn.synIDattr(normal_group, attr)
end

local augroup = vim.api.nvim_create_augroup("ChangeFelineBg", {})

local function change_tmux_with(bg, fg, accent, new_bg)
  vim.fn.system({ "python3", vim.fn.stdpath("config") .. "/change-tmux.py", bg, fg, accent, new_bg })
end

local function apply_telescope_theme(opt)
  local telescope_theme = {
    TelescopeBorder = { fg = opt.bg, bg = opt.bg },
    TelescopePromptCounter = { fg = c.milk, bg = opt.barBg },
    TelescopePromptBorder = { fg = opt.barBg, bg = opt.barBg },
    TelescopePromptNormal = { fg = c.milk, bg = opt.barBg },
    TelescopePromptPrefix = { fg = opt.icon, bg = opt.barBg },

    TelescopeNormal = { bg = opt.bg },

    TelescopePreviewTitle = { fg = c.background, bg = opt.preview },
    TelescopePromptTitle = { fg = c.background, bg = opt.icon },
    TelescopeResultsTitle = { fg = opt.bg, bg = c.milk },

    TelescopeSelection = { bg = c.diff.change },
  }
  local util = require("gruvbox-baby.util")
  for group, colors in pairs(telescope_theme) do
    util.highlight(group, colors)
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  callback = function()
    local utils = require("gruvbox-baby.util")
    local bg = get_hl("Normal", "bg")
    local accent = get_hl("@function.call", "fg")
    local keyword = get_hl("@keyword", "fg")

    local new_bg = utils.darken(bg, 0.85)

    local new_theme = vim.tbl_extend("force", theme, {
      bg = new_bg,
      yellow = accent,
      violet = keyword,
    })
    require("feline").use_theme(new_theme)

    vim.api.nvim_set_hl(0, "DarkNormal", { bg = new_bg })

    local fg = get_hl("Normal", "fg")
    change_tmux_with(bg, fg, keyword, new_bg)
    apply_telescope_theme({
      bg = new_bg,
      preview = keyword,
      icon = get_hl("@accent", "fg"),
      barBg = get_hl("@comment", "fg"),
    })
  end,
})
