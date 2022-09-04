-- Setup nvim-cmp.
-- Setup lspconfig.
local capabilities
if vim.g.using_coq then
  capabilities = vim.lsp.protocol.make_client_capabilities()
else
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

vim.cmd([[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]])
vim.cmd([[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])

local border = {
  { "┌", "FloatBorder" },
  { "─", "FloatBorder" },
  { "┐", "FloatBorder" },
  { "│", "FloatBorder" },
  { "┘", "FloatBorder" },
  { "─", "FloatBorder" },
  { "└", "FloatBorder" },
  { "│", "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-------------------------- SET UP SERVERS ---------------------------------------------

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    timeout_ms = 10000,
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local rename = require("inc_rename")
rename.setup()

-- vim.lsp.set_log_level("debug")
local nvim_lsp = require("lspconfig")
local navic = require("nvim-navic")
local common_on_attach = function(client, bufnr)
  navic.attach(client, bufnr)
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0, silent = true })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0, silent = true })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0, silent = true })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0, silent = true })
  -- nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
  -- nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
  vim.keymap.set("n", "<A-k>", require("lspsaga.diagnostic").goto_prev, { buffer = 0, silent = true, noremap = true })
  vim.keymap.set("n", "<A-j>", require("lspsaga.diagnostic").goto_next, { buffer = 0, silent = true, noremap = true })

  -- " lsp provider to find the cursor word definition and reference
  vim.keymap.set("n", "gh", require("lspsaga.finder").lsp_finder, { buffer = 0, silent = true })

  -- " code action
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0, silent = true })
  vim.keymap.set("v", "<leader>ca", vim.lsp.buf.range_code_action, { buffer = 0, silent = true })

  -- "" show hover doc
  vim.keymap.set("n", "K", require("lspsaga.hover").render_hover_doc, { buffer = 0, silent = true })

  -- "" scroll down hover doc or scroll in definition preview
  vim.keymap.set("n", "<C-d>", function()
    require("lspsaga.action").smart_scroll_with_saga(1)
  end, { buffer = 0, silent = true })
  -- "" scroll up hover doc
  vim.keymap.set("n", "<C-u>", function()
    require("lspsaga.action").smart_scroll_with_saga(-1)
  end, { buffer = 0, silent = true })

  -- "" show signature help
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { buffer = 0, silent = true })

  -- "" rename
  -- vim.keymap.set("n", "<leader>rn", require("lspsaga.rename").lsp_rename, { buffer = 0, silent = true })
  vim.keymap.set("n", "<leader>rn", ":IncRename ")
  vim.keymap.set("n", "<leader>dp", require("lspsaga.definition").preview_definition, { buffer = 0, silent = true })

  -- "" preview definition
  vim.keymap.set("n", "<leader>gd", "<C-]>", { buffer = 0, silent = true })
  vim.keymap.set("n", "<leader>fm", function()
    lsp_formatting(bufnr)
  end, { buffer = 0, silent = true })

  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  -- vim.api.nvim_create_autocmd("BufWritePre", {
  --   group = augroup,
  --   buffer = bufnr,
  --   callback = function()
  --     lsp_formatting(bufnr)
  --   end,
  -- })
end

local filetypes_with_save_on_write_with_no_lsp = { "htmldjango" }

-- format buffers who doesn't have lsp
local ts_utils = require("nvim-lsp-ts-utils")
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = table.concat(filetypes_with_save_on_write_with_no_lsp, ","),
  callback = function(id, group, match, bufnr, file)
    vim.keymap.set("n", "<leader>fm", function()
      lsp_formatting(bufnr)
    end, { buffer = 0, silent = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end,
})

local default_config = {
  capabilities = capabilities,
  flags = { debounce_text_changes = 150 },
  on_attach = common_on_attach,
}

local python_root_files = {
  ".venv",
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
}

local find_cmd = function(cmd, prefixes, start_from, stop_at)
  local path = require("lspconfig/util").path

  if type(prefixes) == "string" then
    prefixes = { prefixes }
  end

  local found
  for _, prefix in ipairs(prefixes) do
    local full_cmd = prefix and path.join(prefix, cmd) or cmd
    local possibility

    -- if start_from is a dir, test it first since transverse will start from its parent
    if start_from and path.is_dir(start_from) then
      possibility = path.join(start_from, full_cmd)
      if vim.fn.executable(possibility) > 0 then
        found = possibility
        break
      end
    end

    path.traverse_parents(start_from, function(dir)
      possibility = path.join(dir, full_cmd)
      if vim.fn.executable(possibility) > 0 then
        found = possibility
        return true
      end
      -- use cwd as a stopping point to avoid scanning the entire file system
      if stop_at and dir == stop_at then
        return true
      end
    end)

    if found ~= nil then
      break
    end
  end

  return found or cmd
end

local server_configurations = {
  ["pyright"] = {
    single_file_support = false,
    root_dir = function(filename, bufnr)
      -- local lines = vim.api.nvim_buf_line_count(bufnr)
      -- if lines > 3000 then
      --   return nil
      -- end
      return nvim_lsp.util.root_pattern(unpack(python_root_files))(filename)
    end,
    capabilities = capabilities,
    on_attach = common_on_attach,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
        },
      },
    },
    before_init = function(_, config)
      local p
      if vim.env.VIRTUAL_ENV then
        p = nvim_lsp.util.path.join(vim.env.VIRTUAL_ENV, "bin", "python3")
      else
        p = find_cmd("python3", ".venv/bin", config.root_dir)
      end
      config.settings.python.pythonPath = p
    end,
  },
  ["sumneko_lua"] = {
    capabilities = capabilities,
    on_attach = common_on_attach,
    flags = { debounce_text_changes = 150 },
    root_dir = nvim_lsp.util.root_pattern(
      ".luarc.json",
      ".luacheckrc",
      ".stylua.toml",
      "stylua.toml",
      "selene.toml",
      ".git"
    ),
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = { enable = false },
      },
    },
  },
  ["tsserver"] = {
    capabilities = capabilities,
    init_options = ts_utils.init_options,
    root_dir = nvim_lsp.util.root_pattern(".yarn", "package.json", ".git"),
    flags = { debounce_text_changes = 150 },
    on_attach = function(client, bufnr)
      -- defaults
      common_on_attach(client, bufnr)
      ts_utils.setup({
        debug = false,
        disable_commands = false,
        enable_import_on_completion = false,

        -- import all
        import_all_timeout = 5000, -- ms
        -- lower numbers = higher priority
        import_all_priorities = {
          same_file = 1, -- add to existing import statement
          local_files = 2, -- git files or files with relative path markers
          buffer_content = 3, -- loaded buffer content
          buffers = 4, -- loaded buffer names
        },
        import_all_scan_buffers = 100,
        import_all_select_source = false,

        -- filter diagnostics
        filter_out_diagnostics_by_severity = {},
        filter_out_diagnostics_by_code = {},

        -- inlay hints
        auto_inlay_hints = true,
        inlay_hints_highlight = "Comment",

        -- update imports on file move
        update_imports_on_move = false,
        require_confirmation_on_move = false,
        watch_dir = nil,
      })

      -- required to fix code action ranges and filter diagnostics
      ts_utils.setup_client(client)

      -- no default maps, so you may want to define some here
      local opts = { silent = true }
      vim.api.nvim_buf_set_keymap(bufnr, "n", "rf", ":TSLspRenameFile<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", ":TSLspImportAll<CR>", opts)
    end,
  },
}

local servers = {
  "pyright",
  "rust_analyzer",
  "tsserver",
  "sumneko_lua",
  "gopls",
  "clangd",
  -- "tailwindcss",
  "cssls",
  "jsonls",
  "html",
  "sqlls",
}

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
})

local coq = require("coq")
for _, lsp in pairs(servers) do
  if vim.g.using_coq then
    require("lspconfig")[lsp].setup(coq.lsp_ensure_capabilities(server_configurations[lsp] or default_config))
  else
    require("lspconfig")[lsp].setup(server_configurations[lsp] or default_config)
  end
end

-- local rt = require("rust-tools")

local function config_wrapper(config)
  if vim.g.using_coq then
    return require("coq").lsp_ensure_capabilities(config)
  end
  return config
end

-- rt.setup({
--   server = config_wrapper({ on_attach = common_on_attach }),
-- })

------------------------------------------------------------------------------------------
------------------------------- null ls --------------------------------------------------
local null_ls = require("null-ls")
local fmt = null_ls.builtins.formatting
local dg = null_ls.builtins.diagnostics
local ca = null_ls.builtins.code_actions

local _debug = function(content)
  local f = io.open("/home/acc/.nvim.debug.log", "a")
  f:write(content .. "\n")
  f.close()
end

local lsputil = require("lspconfig.util")
local root_has_file = function(name)
  local cwd = vim.loop.cwd()
  return lsputil.path.exists(lsputil.path.join(cwd, name))
end

null_ls.setup({
  autostart = true,
  default_timeout = 10000,
  sources = {
    fmt.trim_whitespace.with({
      filetypes = { "text", "sh", "zsh", "yaml", "toml", "make", "conf", "tmux" },
    }),
    fmt.rustfmt,
    fmt.stylua,
    fmt.gofmt,
    fmt.black.with({
      prefer_local = ".venv/bin",
      args = { "--quiet", "-" },
      extra_args = { "--line-length", "120" },
    }),
    -- fmt.isort,
    fmt.isort.with({
      -- condition = function(utils)
      -- return root_has_file("pyproject.toml")
      -- end,
      args = function(params)
        local lsputil = require("lspconfig.util")
        local root = nvim_lsp.pyright.get_root_dir(params.bufname)
        local config = {
          "--stdout",
        }
        if lsputil.path.exists(lsputil.path.join(root, "pyproject.toml")) then
          table.insert(config, "--settings-path")
          table.insert(config, root)
        end
        table.insert(config, "--filename")
        table.insert(config, "$FILENAME")
        table.insert(config, "-")
        return config
      end,
    }),
    fmt.djhtml,
    fmt.eslint_d,
    fmt.prettierd,
    -- dg.tsc,
    dg.eslint_d,
    dg.flake8,
    ca.eslint_d,
    ca.refactoring,
  },
})

------------------------------------------------------------------------------------------

vim.lsp.protocol.CompletionItemKind = {
  " [text]",
  " [method]",
  "ƒ [function]",
  " [constructor]",
  " [field]",
  " [variable]",
  " [class]",
  " [interface]",
  " [module]",
  " [property]",
  " [unit]",
  " [value]",
  " [enum]",
  " [keyword]",
  "﬌ [snippet]",
  " [color]",
  " [file]",
  " [reference]",
  " [dir]",
  " [enummember]",
  " [constant]",
  " [struct]",
  "  [event]",
  " [operator]",
  " [type]",
}

local saga = require("lspsaga")
saga.init_lsp_saga({
  code_action_icon = "💡",
  code_action_lightbulb = {
    enable = true,
    sign = true,
    enable_in_insert = true,
    sign_priority = 5,
    virtual_text = false,
  },
})

function PrintDiagnostics()
  local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
  local diagnostics = vim.diagnostic.get(0, { lnum = lnum })
  if vim.tbl_isempty(diagnostics) then
    print("")
    return
  end
  for i, diagnostic in ipairs(diagnostics) do
    print(string.format("%d: %s", i, diagnostic.message))
  end
end

vim.cmd([[ autocmd CursorHold * lua PrintDiagnostics() ]])

-- "" float terminal also you can pass the cli command in open_float_terminal function
vim.cmd([[nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>]])
vim.cmd([[tnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>]])

vim.cmd([[sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=]])

vim.diagnostic.config({
  underline = false,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
})

_G.cancel_all = function()
  local clients = vim.lsp.buf_get_clients()
  for _, client in pairs(clients) do
    for id, _ in pairs(client.requests) do
      client.cancel_request(id)
    end
  end
  vim.notify("Cleaned!")
end

_G.remove_hidden_buffers = function()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.fn.getbufinfo(bufnr)[1].hidden == 1 then
      pcall(vim.api.nvim_buf_delete, bufnr, {})
    end
  end
end

vim.cmd([[nnoremap <leader>aa :lua cancel_all()<CR>]])
