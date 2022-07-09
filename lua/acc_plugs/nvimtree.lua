vim.cmd([[nnoremap <leader>ce :NvimTreeToggle<CR>]])
vim.cmd([[nnoremap <leader>r :NvimTreeRefresh<CR>]])
vim.cmd([[nnoremap <leader>n :NvimTreeFindFile<CR>]])
-- " NvimTreeOpen and NvimTreeClose are also available if you need them

require("nvim-tree").setup({
  disable_netrw = true,
  hijack_netrw = true,
  prefer_startup_root = true,
  open_on_setup_file = true,
  open_on_tab = false,
  ignore_ft_on_setup = {},
  update_cwd = true,
  hijack_cursor = true,
  hijack_directories = {
    auto_open = false,
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
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
    mappings = {
      custom_only = false,
      list = {},
    },
  },
  git = {
    enable = true,
    ignore = false,
  },
  renderer = {
    icons = {
      webdev_colors = true,
      git_placement = "before",
    },
  },
  live_filter = {
    prefix = "🔎 >",
  },
})
