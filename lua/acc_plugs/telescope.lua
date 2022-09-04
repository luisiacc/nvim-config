require("luisiacc")

local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")

local funcs = require("luisiacc.tel_functions")
local tb = require("telescope.builtin")

local nnoremap = function(lhs, rhs)
  vim.keymap.set("n", lhs, rhs)
end

nnoremap("<leader>fw", funcs.grep_string_under_cursor)
nnoremap("<leader>ps", funcs.live_grep)
-- nnoremap("<leader>fb", funcs.file_browser)

nnoremap("<C-p>", funcs.find_files)
nnoremap("<leader>ft", tb.treesitter)
nnoremap("<Leader>em", funcs.search_nvim_config)
nnoremap("<leader>pw", funcs.live_grep_under_cursor)
nnoremap("<leader>ff", ":Ag<cr>")
-- nnoremap("<leader>FF", funcs.search_all_files)

-- vim.cmd([[nnoremap <leader>fw :lua require('telescope.builtin').grep_string({ sort_only_text = true })<CR>]])
nnoremap("<leader>pb", tb.buffers)
nnoremap("<leader>t", funcs.tags)
nnoremap("<leader>vh", tb.help_tags)
nnoremap("<leader>F", funcs.find_in_buffer)
nnoremap("<leader>gc", tb.git_branches)
nnoremap("<leader>gp", function()
  require("telescope").extensions.project.project({})
end)

local delta = require("luisiacc.delta")
nnoremap("<leader>c", delta.commits)
nnoremap("<leader>bc", delta.bcommits)
nnoremap("<leader>gs", delta.status)
nnoremap("<leader><leader>", funcs.frecency)
