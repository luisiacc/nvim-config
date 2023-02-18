-- " NvimTreeOpen and NvimTreeClose are also available if you need them

require("nvim-tree").setup({
  reload_on_bufenter = true,
  auto_reload_on_write = true,
  disable_netrw = true,
  hijack_netrw = true,
  prefer_startup_root = true,
  open_on_tab = false,
  sync_root_with_cwd = true,
  hijack_cursor = true,
  hijack_directories = {
    enable = true,
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
    update_root = true,
    ignore_list = { "startify" },
  },
  system_open = {
    cmd = nil,
    args = {},
  },
  view = {
    width = 45,
    side = "right",
    signcolumn = "no",
    -- adaptive_size = true,
    centralize_selection = true,
    mappings = {
      custom_only = false,
      list = {
        { key = "<CR>", action = "edit_in_place" },
      },
    },
  },
  git = {
    enable = true,
    ignore = false,
  },
  renderer = {
    full_name = true,
    highlight_git = true,
    indent_markers = {
      enable = true,
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
    },
  },
  live_filter = {
    prefix = "🔎 >",
  },
})

local function toggle_replace()
  local view = require("nvim-tree.view")
  if view.is_visible() then
    view.close()
  else
    require("nvim-tree").open_replacing_current_buffer()
  end
end

vim.keymap.set("n", "<leader>ce", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>r", "<cmd>NvimTreeRefresh<CR>")
vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeFindFile<CR>")
vim.keymap.set("n", "<leader>i", toggle_replace)

local function open_nvim_tree(data)
  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not no_name and not directory then
    return
  end

  -- change to the directory
  if directory then
    vim.cmd.cd(data.file)
  end

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
