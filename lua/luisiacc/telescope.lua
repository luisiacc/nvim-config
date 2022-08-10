local resolve = require("telescope.config.resolve")
local p_window = require("telescope.pickers.window")

local get_border_size = function(opts)
  if opts.window.border == false then
    return 0
  end

  return 1
end

local calc_tabline = function(max_lines)
  local tbln = (vim.o.showtabline == 2) or (vim.o.showtabline == 1 and #vim.api.nvim_list_tabpages() > 1)
  if tbln then
    max_lines = max_lines - 1
  end
  return max_lines, tbln
end
local if_nil = vim.F.if_nil

local calc_size_and_spacing = function(cur_size, max_size, bs, w_num, b_num, s_num)
  local spacing = s_num * (1 - bs) + b_num * bs
  cur_size = math.min(cur_size, max_size)
  cur_size = math.max(cur_size, w_num + spacing)
  return cur_size, spacing
end

local a_bottom_pane = function(picker, max_columns, max_lines, layout_config)
  local initial_options = p_window.get_initial_window_options(picker)
  local results = initial_options.results
  local prompt = initial_options.prompt
  local preview = initial_options.preview

  local tbln
  max_lines, tbln = calc_tabline(max_lines)

  local height = if_nil(resolve.resolve_height(layout_config.height)(picker, max_columns, max_lines), 25)
  if type(layout_config.height) == "table" and type(layout_config.height.padding) == "number" then
    -- Since bottom_pane only has padding at the top, we only need half as much padding in total
    -- This doesn't match the vim help for `resolve.resolve_height`, but it matches expectations
    height = math.floor((max_lines + height) / 2)
  end

  local bs = get_border_size(picker)

  -- Cap over/undersized height
  height, _ = calc_size_and_spacing(height, max_lines, bs, 2, 3, 0)

  -- Height
  prompt.height = 1
  results.height = height - prompt.height - (2 * bs)
  preview.height = results.height - bs

  -- Width
  if picker.previewer and max_columns >= layout_config.preview_cutoff then
    -- Cap over/undersized width (with preview)
    local width, w_space = calc_size_and_spacing(max_columns, max_columns, bs, 2, 4, 0)

    preview.width = resolve.resolve_width(if_nil(layout_config.preview_width, 0.5))(picker, width, max_lines)
    results.width = width - preview.width - w_space
    prompt.width = results.width
  else
    results.width = prompt.width
    preview.width = 0
    prompt.width = results.width
  end

  -- Line
  if layout_config.prompt_position == "top" then
    prompt.line = max_lines - results.height - (1 + bs) + 1
    results.line = prompt.line + 1
    preview.line = results.line + bs
    if results.border == true then
      results.border = { 0, 1, 1, 1 }
    end
    if type(results.title) == "string" then
      results.title = { { pos = "S", text = results.title } }
    end
  elseif layout_config.prompt_position == "bottom" then
    results.line = max_lines - results.height - (1 + bs) + 1
    preview.line = results.line
    prompt.line = max_lines - bs
    if type(prompt.title) == "string" then
      prompt.title = { { pos = "S", text = prompt.title } }
    end
    if results.border == true then
      results.border = { 1, 1, 0, 1 }
    end
  else
    error("Unknown prompt_position: " .. tostring(picker.window.prompt_position) .. "\n" .. vim.inspect(layout_config))
  end

  -- Col
  prompt.col = 0 -- centered
  if layout_config.mirror and preview.width > 0 then
    results.col = preview.width + (3 * bs) + 1
    preview.col = bs + 1
  else
    results.col = bs + 1
    preview.col = results.width + (3 * bs) + 1
  end

  if tbln then
    prompt.line = prompt.line + 1
    results.line = results.line + 1
    preview.line = preview.line + 1
  end

  return {
    preview = picker.previewer and preview.width > 0 and preview,
    prompt = prompt,
    results = results,
  }
end

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
      i = {
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<A-j>"] = actions.move_selection_next,
        ["<A-k>"] = actions.move_selection_previous,
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
