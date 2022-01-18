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
  defaults = ivy({
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    file_ignore_patterns = { ".venv", "node_modules" },
    scroll_strategy = "cycle",
    -- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    mappings = {
      i = {
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<A-j>"] = actions.move_selection_next,
        ["<A-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
      },
    },
  }),
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
})

require("telescope").load_extension("fzf")
