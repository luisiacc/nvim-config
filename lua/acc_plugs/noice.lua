local enable_message = "mini"

require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  signature = { enabled = false },
  -- you can enable a preset for easier configuration
  views = {
    popupmenu = {
      relative = "editor",
      -- position = {
      --   row = "40%",
      --   col = "50%",
      -- },
      size = {
        width = 120,
        height = 10,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      },
    },
    cmdline_mine = {
      backend = "popup",
      relative = "editor",
      focusable = false,
      enter = false,
      zindex = 60,
      size = {
        min_width = 150,
        width = "auto",
        height = "auto",
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = {
          Normal = "NoiceCmdlinePopup",
          FloatBorder = "NoiceCmdlinePopupBorder",
          IncSearch = "",
          Search = "",
        },
        cursorline = false,
      },
    },
  },
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    -- command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
    -- cmdline_output_to_split=true,
  },
  messages = {
    enabled = true, -- enables the Noice messages UI
    view = 'mini', -- default view for messages
    view_error = "mini", -- view for errors
    view_warn = "notify", -- view for warnings
    view_history = "messages", -- view for :messages
    view_search = false, -- view for search count messages. Set to `false` to disable
  },
  routes = {
    {
      view = "notify",
      filter = { event = "msg_showmode" },
    },
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
    },
  },
})

vim.cmd([[nmap <leader>b <cmd>Noice history<CR>]])
