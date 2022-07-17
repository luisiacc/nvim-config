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

local gps = require("nvim-gps")
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
      fg = c.dark,
      bg = c.bright_yellow,
      style = "bold",
    },
    left_sep = {
      "left_rounded",
      { str = " ", hl = { bg = c.soft_yellow, fg = "NONE" } },
    },
    right_sep = {
      { str = " ", hl = { bg = c.soft_yellow, fg = "NONE" } },
      "right_rounded",
      " ",
    },
  },
  {
    provider = "file_size",
    right_sep = {
      " ",
      {
        str = "left_rounded_thin",
        hl = {
          fg = "fg",
          bg = "bg",
        },
      },
    },
  },
  {
    provider = "position",
    left_sep = " ",
    right_sep = {
      " ",
      {
        str = "right_rounded_thin",
        hl = {
          fg = "fg",
          bg = "bg",
        },
      },
    },
  },
  {
    provider = "diagnostic_errors",
    hl = { fg = "red" },
  },
  {
    provider = "diagnostic_warnings",
    hl = { fg = "yellow" },
  },
  {
    provider = "diagnostic_hints",
    hl = { fg = "cyan" },
  },
  {
    provider = "diagnostic_info",
    hl = { fg = "skyblue" },
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
    provider = "git_diff_added",
    hl = {
      fg = "green",
      bg = "black",
    },
  },
  {
    provider = "git_diff_changed",
    hl = {
      fg = "orange",
      bg = "black",
    },
  },
  {
    provider = "git_diff_removed",
    hl = {
      fg = "red",
      bg = "black",
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
  {
    provider = "scroll_bar",
    hl = {
      fg = "skyblue",
      style = "bold",
    },
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

M.statusline.noicons.active[1] = {
  {
    provider = "▊ ",
    hl = {
      fg = "skyblue",
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
    right_sep = " ",
    icon = "",
  },
  {
    provider = "file_info",
    hl = {
      fg = "white",
      bg = "oceanblue",
      style = "bold",
    },
    left_sep = "",
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
    icon = "",
  },
  {
    provider = "file_size",
    right_sep = {
      " ",
      {
        str = "vertical_bar_thin",
        hl = {
          fg = "fg",
          bg = "bg",
        },
      },
    },
  },
  {
    provider = "position",
    left_sep = " ",
    right_sep = {
      " ",
      {
        str = "vertical_bar_thin",
        hl = {
          fg = "fg",
          bg = "bg",
        },
      },
    },
  },
  {
    provider = "diagnostic_errors",
    hl = { fg = "red" },
    icon = " E-",
  },
  {
    provider = "diagnostic_warnings",
    hl = { fg = "yellow" },
    icon = " W-",
  },
  {
    provider = "diagnostic_hints",
    hl = { fg = "cyan" },
    icon = " H-",
  },
  {
    provider = "diagnostic_info",
    hl = { fg = "skyblue" },
    icon = " I-",
  },
  {
    provider = function()
      return require("nvim-gps").get_location()
    end,
    hl = { fg = "skyblue" },
    enabled = function()
      return require("nvim-gps").is_available()
    end,
  },
}

M.statusline.noicons.active[2] = {
  {
    provider = "git_branch",
    hl = {
      fg = "white",
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
    icon = " ",
  },
  {
    provider = "git_diff_added",
    hl = {
      fg = "green",
      bg = "black",
    },
    icon = " +",
  },
  {
    provider = "git_diff_changed",
    hl = {
      fg = "orange",
      bg = "black",
    },
    icon = " ~",
  },
  {
    provider = "git_diff_removed",
    hl = {
      fg = "red",
      bg = "black",
    },
    right_sep = {
      str = " ",
      hl = {
        fg = "NONE",
        bg = "black",
      },
    },
    icon = " -",
  },
  {
    provider = "line_percentage",
    hl = {
      style = "bold",
    },
    left_sep = "  ",
    right_sep = " ",
  },
  {
    provider = "scroll_bar",
    hl = {
      fg = "skyblue",
      style = "bold",
    },
  },
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
