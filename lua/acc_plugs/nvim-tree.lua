-- " NvimTreeOpen and NvimTreeClose are also available if you need them

require("nvim-tree").setup({
  reload_on_bufenter = true,
  auto_reload_on_write = true,
  disable_netrw = true,
  hijack_netrw = true,
  prefer_startup_root = true,
  open_on_tab = false,
  respect_buf_cwd = true,
  sync_root_with_cwd = false,
  hijack_cursor = true,
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = {
      "node_modules",
    },
  },
  actions = {
    open_file = {
      eject = false,
      resize_window = false,
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
    side = "left",
    signcolumn = "no",
    -- adaptive_size = true,
    centralize_selection = true,
    preserve_window_proportions = false,
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
      show = {
        folder = true,
        folder_arrow = true,
      },
      -- glyphs = {
      --   folder = {
      --     arrow_closed = "",
      --     arrow_open = "",
      --     default = "",
      --     open = "",
      --     empty = "",
      --     empty_open = "",
      --     symlink = "",
      --     symlink_open = "",
      --   },
      -- },
    },
  },
  live_filter = {
    prefix = "🔎 >",
  },
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set("n", "<CR>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
  end,
})

local function toggle_replace()
  local api = require("nvim-tree.api")
  if api.tree.is_visible() then
    api.tree.close()
  else
    print("Helloooooo")
    api.tree.open({ current_window = true })
  end
end

vim.keymap.set("n", "<leader>ce", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>r", "<cmd>NvimTreeRefresh<CR>")
vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeFindFile<CR>")
vim.keymap.set("n", "<leader>o", toggle_replace)

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
