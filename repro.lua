-- DO NOT change the paths and don't remove the colorscheme
local root = vim.fn.fnamemodify("./.repro", ":p")
-- set stdpaths to use .repro
for _, name in ipairs({ "config", "data", "state", "cache" }) do
  vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
end

-- bootstrap lazy
local lazypath = root .. "/plugins/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.runtimepath:prepend(lazypath)

-- install plugins
local plugins = {
  "folke/tokyonight.nvim",
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        cmdline = {
          view = "cmdline_mine",
        },
        signature = { enabled = false },
        -- you can enable a preset for easier configuration
        views = {
          popupmenu = {
            relative = "editor",
            position = {
              row = "40%",
              col = "50%",
            },
            size = {
              width = 60,
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
            position = {
              row = "30%",
              col = "50%",
            },
            size = {
              min_width = 100,
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
          inc_rename = true, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
          -- cmdline_output_to_split=true,
        },
        messages = {
          enabled = true, -- enables the Noice messages UI
          view = "mini", -- default view for messages
          view_error = "notify", -- view for errors
          view_warn = "notify", -- view for warnings
          view_history = "messages", -- view for :messages
          view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
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
    end,
  },
  "MunifTanjim/nui.nvim",
}
require("lazy").setup(plugins, {
  root = root .. "/plugins",
})

vim.cmd.colorscheme("tokyonight")
-- add anything else here

local count = 0
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(ev)
    count = count + 1
    print(count)
  end,
})
