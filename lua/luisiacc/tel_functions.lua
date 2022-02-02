local builtin = require("telescope.builtin")

local M = {}

function M.grep_string_under_cursor()
  builtin.grep_string({ path_display = "shorten", search = vim.fn.expand("<cword>") })
end

function M.live_grep_under_cursor()
  return builtin.live_grep({ path_display = "shorten", search = vim.fn.expand("<cword>") })
end

function M.live_grep()
  return builtin.live_grep({ path_display = "shorten", sort_only_text = true })
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
  return builtin.grep_string({ sort_only_text = true })
end

function M.tags()
  return builtin.tags({ path_display = "shorten", sort_only_text = true })
end

function M.find_in_buffer()
  return builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    border = true,
    previewer = false,
    layout_config = { width = 0.70, height = 0.70 },
  }))
end

return M
