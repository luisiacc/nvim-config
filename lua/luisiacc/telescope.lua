local resolve = require("telescope.config.resolve")
local p_window = require("telescope.pickers.window")
local actions = require("telescope.actions")

local full_theme = {
  winblend = 20,
  width = 0.8,
  show_line = false,
  prompt_prefix = "TS Symbols>",
  prompt_title = "",
  results_title = "",
  preview_title = "",
  borderchars = {
    prompt = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
    results = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
    preview = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
  },
}

local no_preview = function()
  return require("telescope.themes").get_dropdown({
    borderchars = {
      { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
      preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
    width = 0.8,
    previewer = false,
    prompt_title = false,
  })
end

local vscode_finder = function(opts)
  local theme_opts = require("telescope.themes").get_ivy(opts)
  theme_opts.theme = "vscode"
  return vim.tbl_deep_extend("force", theme_opts, opts)
end

local ivy = require("telescope.themes").get_ivy

local actions = require("telescope.actions")
require("telescope").setup({
  pickers = { buffers = { sort_lastused = true, theme = "ivy" } },
  defaults = {
    prompt_prefix = "   ",
    selection_caret = "❯ ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    file_ignore_patterns = { ".venv", "node_modules" },
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    -- layout_strategy = "horizontal",
    -- layout_strategy = a_bottom_pane,
    layout_strategy = "bottom_pane",
    -- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    color_devicons = true,
    winblend = 0,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.5,
        results_width = 0.6,
      },
      bottom_pane = {
        prompt_position = "top",
        preview_width = 0.6,
        results_width = 0.5,
      },
      vertical = {
        mirror = false,
      },
      height = 0.85,
      width = 0.85,
      preview_cutoff = 150,
    },
    -- border = {},
    -- borderchars = { " " },
    -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    borderchars = {
      prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
      results = { " " },
      preview = { " " },
    },
    mappings = {
      n = {
        ["<a-i>"] = actions.to_fuzzy_refine,
      },
      i = {
        ["<a-i>"] = actions.to_fuzzy_refine,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<A-j>"] = actions.move_selection_next,
        ["<A-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
      },
    },
  },
  extensions = {
    frecency = {
      db_root = "/home/acc/.vim",
    },
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    project = {
      base_dirs = {
        "~/projects",
      },
      hidden_files = true, -- default: false
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("project")
pcall(require("telescope").load_extension, "frecency")
