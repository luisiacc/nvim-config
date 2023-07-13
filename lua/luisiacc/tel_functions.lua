local builtin = require("telescope.builtin")
local sorters = require("telescope.sorters")

local M = {}

M.no_preview = function()
  local theme = require("telescope.themes").get_dropdown({
    borderchars = {
      { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
      preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
    width = 150,
    previewer = false,
    prompt_title = false,
  })
  theme.layout_config.width = 0.7
  theme.layout_config.height = 0.5
  return theme
end

function M.grep_string_under_cursor()
  builtin.grep_string({ path_display = "shorten", search = vim.fn.expand("<cword>") })
end

function M.live_grep_under_cursor()
  return builtin.live_grep({ path_display = "shorten", search = vim.fn.expand("<cword>") })
end

function M.live_grep()
  return builtin.live_grep({ path_display = "shorten", sort_only_text = true, use_regex = true })
end

function M.search_nvim_config()
  return builtin.find_files({ prompt = "~ nvim config ~", cwd = "~/.config/nvim" })
end

function M.search_all_files()
  return builtin.find_files({
    find_command = { "rg", "--no-ignore", "--files" },
  })
end

function M.grep_string()
  return builtin.grep_string({
    short_path = true,
    word_match = "-w",
    only_sort_text = true,
    -- layout_strategy = "vertical",
    sorter = sorters.get_fzy_sorter(),
  })
end

function M.tags()
  return builtin.tags({ only_sort_tags = true, fname_width = 40 })
end

function M.find_in_buffer()
  return builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    border = true,
    previewer = false,
    layout_config = { width = 0.70, height = 0.70 },
  }))
end

function M.find_files()
  return builtin.find_files(M.no_preview())
end

function M.find_file_under_cursor()
  builtin.find_files({ search_file = vim.fn.expand("<cword>") })
end
local nnoremap = function(lhs, rhs)
  vim.keymap.set("n", lhs, rhs)
end
nnoremap("<leader>gf", M.find_file_under_cursor)

function M.frecency()
  require("telescope").extensions.frecency.frecency()
end

return M
