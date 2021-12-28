vim.g.nvim_tree_auto_ignore_ft = { "startify" } --empty by default, don't auto open tree on specific filetypes.
vim.g.nvim_tree_quit_on_open = 0 -- 0 by default, closes the tree when you open a file
vim.g.nvim_tree_indent_markers = 1 -- 0 by default, this option shows indent markers when folders are open
-- let g:nvim_tree_hide_dotfiles = 1 "0 by default, this option hides files and folders starting with a dot `.`
vim.g.nvim_tree_git_hl = 1 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
vim.g.nvim_tree_root_folder_modifier = ":~" -- This is the default. See :help filename-modifiers for more options
vim.g.nvim_tree_width_allow_resize = 1 -- 0 by default, will not resize the tree when opening a file
vim.g.nvim_tree_add_trailing = 1 -- 0 by default, append a trailing slash to folder names
vim.g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
}

-- "If 0, do not show the icons for one of 'git' 'folder' and 'files'
-- "1 by default, notice that if 'files' is 1, it will only display
-- "if nvim-web-devicons is installed and on your runtimepath

-- " default will show icon by default if no icon is provided
-- " default shows no icon by default
vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "✗",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    untracked = "★",
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
}

vim.cmd([[nnoremap <leader>ce :NvimTreeToggle<CR>]])
vim.cmd([[nnoremap <leader>r :NvimTreeRefresh<CR>]])
vim.cmd([[nnoremap <leader>n :NvimTreeFindFile<CR>]])
-- " NvimTreeOpen and NvimTreeClose are also available if you need them

-- " a list of groups can be found at `:help nvim_tree_highlight`
vim.cmd([[highlight NvimTreeFolderIcon guibg=blue]])

require("nvim-tree").setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {},
  follow = true,
  auto_open = true,
  auto_close = false,
  open_on_tab = false,
  update_cwd = true,
  hijack_cursor = false,
  update_to_buf_dir = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = { "startify" },
  },
  system_open = {
    cmd = nil,
    args = {},
  },
  view = {
    width = 40,
    side = "right",
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = {},
    },
  },
  git = {
    enable = true,
    ignore = false,
  },
})
