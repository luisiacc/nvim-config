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

local gps = require("nvim-navic")
local file_color = c.soft_yellow
-- local file_color = c.soft_yellow
M.statusline.icons.active[1] = {
  {
    provider = "▊ ",
    hl = {
      fg = c.soft_yellow,
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
      fg = "bg",
      bg = file_color,
      style = "bold",
    },
    left_sep = {
      { str = "left_rounded", hl = { bg = "bg", fg = c.soft_yellow } },
      { str = " ", hl = { bg = file_color, fg = "bg" } },
    },
    right_sep = {
      { str = " ", hl = { bg = file_color, fg = "bg" } },
      { str = "right_rounded", hl = { bg = "bg", fg = c.soft_yellow } },
      " ",
    },
  },
  {
    provider = "file_size",
    right_sep = {
      " ",
      { str = "left_rounded", hl = { bg = "bg", fg = c.soft_yellow } },
    },
  },
  {
    provider = "position",
    left_sep = { str = " ", hl = { bg = c.soft_yellow, fg = "bg" } },
    hl = {
      fg = "bg",
      bg = file_color,
      style = "bold",
    },
    right_sep = {
      { str = " ", hl = { bg = c.soft_yellow, fg = "bg" } },
      { str = "right_rounded", hl = { bg = "bg", fg = c.soft_yellow } },
    },
  },
  {
    provider = "diagnostic_errors",
    hl = { fg = "red" },
  },
}

M.statusline.icons.active[2] = {
  {
    provider = "git_branch",
    hl = {
      fg = "orange",
      bg = "black",
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

M.statusline.noicons.inactive[1] = {
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
      " ",
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
  {
    provider = function()
      return gps.get_location()
    end,
    hl = { fg = "skyblue", bg = "NONE", style = "bold" },
    enabled = function()
      return gps.is_available()
    end,
    left_sep = {
      { str = " ❯ ", hl = { bg = "NONE", fg = "skyblue" } },
    },
  },
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

M.winbar.noicons.active[1] = {
  {
    provider = "file_info",
    hl = {
      fg = "skyblue",
      bg = "NONE",
      style = "bold",
    },
    icon = "",
  },
}

M.winbar.noicons.inactive[1] = {
  {
    provider = "file_info",
    hl = {
      fg = "white",
      bg = "NONE",
      style = "bold",
    },
    icon = "",
  },
}

require("feline").setup({ components = M.statusline.icons })
require("feline").winbar.setup({ components = M.winbar.icons })
