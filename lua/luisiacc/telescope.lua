
local full_theme = {
  winblend = 20;
  width = 0.8;
  show_line = false;
  prompt_prefix = 'TS Symbols>';
  prompt_title = '';
  results_title = '';
  preview_title = '';
  borderchars = {
    prompt = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
    results = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
    preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
  };
}

local no_preview = function()
  return require('telescope.themes').get_dropdown({
    borderchars = {
      { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
      prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
      results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
      preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
    },
    width = 0.8,
    previewer = false,
    prompt_title = false
  })
end

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    prompt_position = "bottom",
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {".venv", "node_modules"},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
    mappings = {
        i = {
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<A-j>"] = actions.move_selection_next,
            ["<A-k>"] = actions.move_selection_previous,
            ["<esc>"] = actions.close,
        },
    }
  },
  extensions = {
      fzy_native = {
          override_generic_sorter = true,
          override_file_sorter = true,
      }
  }
}

require('telescope').load_extension('fzy_native')

local M = {}
            -- map(mode, key, lua function to call)
            --
            -- good place to look: telescope.actions (init.lua)
            -- lua function to call:  (gets bufnr, not necessarily needed)
            --   require('telescope.actions.state').get_selected_entry(bufnr)
            --   Actions just take the bufnr and give out information
            --   require('telescope.actions').close(bufnr)
            --
            --   check out telescope.actions for _all the available_ supported
            --   actions.
            --
            --   :h telescope.setup ->
            --   :h telescope.builtin ->
            --   :h telescope.layout ->
            --   :h telescope.actions
            --
-- M.git_branches = function() 
--     require("telescope.builtin").git_branches({
--         attach_mappings = function(prompt_bufnr, map) 
--             map('i', '<c-d>', actions.git_delete_branch)
--             map('n', '<c-d>', actions.git_delete_branch)
--             map('i', '<A-j>', actions.move_selection_next)
--             map('i', '<A-k>', actions.move_selection_previous)
--             return true
--         end
--     })
-- end

return M
