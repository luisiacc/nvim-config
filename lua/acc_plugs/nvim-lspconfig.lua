-- Setup nvim-cmp.
-- Setup lspconfig.lspc
local capabilities
if vim.g.using_coq then
  capabilities = vim.lsp.protocol.make_client_capabilities()
else
  capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
end
-- vim.lsp.set_log_level'trace'
-- if vim.fn.has 'nvim-0.5.1' == 1 then
-- 	require('vim.lsp.log').set_format_func(vim.inspect)
-- end

-- require("lspsaga").setup({
--   code_action_icon = "💡",
--   code_action_lightbulb = {
--     enable = true,
--     sign = true,
--     enable_in_insert = true,
--     sign_priority = 5,
--     virtual_text = false,
-- }})

-- vim.cmd([[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]])
-- vim.cmd([[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])
--
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

-- vim.lsp.set_config({
--   flags = {
--     allow_incremental_sync = true,
--     debounce_text_changes = 500,
--   },
-- })

local prefetch_definitions = function()
  local params = {
    textDocument = vim.lsp.util.make_text_document_params(),
  }
  -- vim.lsp.buf_request(0, "textDocument/documentSymbol", params, function(err, result)
  --   if err or not result then
  --     return
  --   end
  --   for _, symbol in ipairs(result) do
  --     if symbol.location then
  --       local def_params = {
  --         textDocument = params.textDocument,
  --         position = symbol.location.range.start,
  --       }
  --       vim.lsp.buf_request(0, "textDocument/definition", def_params, function() end) -- Empty callback to discard results
  --     end
  --   end
  -- end)
end

-------------------------- SET UP SERVERS ---------------------------------------------

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    timeout_ms = 10000,
    filter = function(client)
      return client.name == "null-ls" or client.name == "ruff" or client.name == "eslint"
    end,
    bufnr = bufnr,
  })

  -- Organize imports only for Python files
  if vim.bo.filetype == "python" then
    vim.lsp.buf.code_action({
      filter = function(action)
        return action.title == "Ruff: Organize Imports"
      end,
      apply = true,
    })
  end
end

_G.format = lsp_formatting

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- vim.lsp.set_log_level("debug")
local nvim_lsp = require("lspconfig")
-- local navic = require("nvim-navic")

local common_on_attach = function(with_navic)
  return function(client, bufnr)
    if client.name == "ruff" then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end

    -- client.server_capabilities.semanticTokensProvider = nil -- turn off semantic tokens
    -- pcall(prefetch_definitions)
    -- client.server_capabilities.document_formatting = false
    -- client.server_capabilities.document_range_formatting = false

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, silent = true })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, silent = true })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, silent = true })

    -- nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
    -- nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    vim.keymap.set("n", "<leader>qk", function()
      -- require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
      vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { buffer = bufnr, silent = true, noremap = true })

    vim.keymap.set("n", "<leader>qj", function()
      -- require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { buffer = bufnr, silent = true, noremap = true })

    vim.keymap.set("n", "H", vim.diagnostic.open_float, { buffer = bufnr, silent = true })

    -- " code action
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, silent = true })
    vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, silent = true })

    -- "" show hover doc
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, silent = true })

    -- "" show signature help
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { buffer = bufnr, silent = true })

    -- "" rename
    vim.keymap.set("n", "<leader>rn", ":IncRename ")

    -- "" preview definition
    vim.keymap.set("n", "<leader>gd", "<C-]>", { buffer = bufnr, silent = true })
    vim.keymap.set("n", "<leader>ai", function()
      vim.lsp.buf.code_action({
        filter = function(action)
          return action.title:lower():match("import") or action.title:lower():match("add import")
        end,
        apply = true,
      })
    end, { buffer = 0, silent = true, desc = "Auto import" })
  end
end

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true })
vim.keymap.set("n", "<leader>fm", function()
  lsp_formatting(nil)
end, { silent = true })

local filetypes_with_save_on_write_with_no_lsp = { "htmldjango" }

local function patch(result)
  if not vim.tbl_islist(result) or type(result) ~= "table" then
    return result
  end

  return { result[1] }
end

local function handle_go_to_definition(err, result, ctx, ...)
  vim.lsp.handlers["textDocument/definition"](err, patch(result), ctx, ...)
end

local default_config = {
  capabilities = capabilities,
  on_attach = common_on_attach(true),
  on_init = function(client, _)
    client.server_capabilities.semanticTokensProvider = nil -- turn off semantic tokens
  end,
}

local python_root_files = {
  ".venv",
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
  ".git",
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

local function filter(arr, fn)
  if type(arr) ~= "table" then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

local function filterReactDTS(value)
  return string.match(value.uri, "react/index.d.ts") == nil
end

local server_configurations = {
  ["ruff"] = {
    on_attach = common_on_attach(false),
    root_dir = function(filename, bufnr)
      -- local lines = vim.api.nvim_buf_line_count(bufnr)
      -- if lines > 3000 then
      --   return nil
      -- end
      return nvim_lsp.util.root_pattern(unpack(python_root_files))(filename)
    end,
  },
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
    on_attach = function(client, bufnr)
      common_on_attach(true)(client, bufnr)
    end,
    -- settings = {
    --   python = {
    --     analysis = {
    --       autoSearchPaths = true,
    --       useLibraryCodeForTypes = true,
    --       diagnosticMode = "openFilesOnly",
    --     },
    --   },
    -- },
    -- use ruff for linting
    settings = {
      pyright = {
        -- Using Ruff's import organizer
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          -- Ignore all files for analysis to exclusively use Ruff for linting
          ignore = { "*" },
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
  ["lua_ls"] = {
    capabilities = capabilities,
    on_attach = common_on_attach(true),
    root_dir = function(filename, bufnr)
      -- if ".config/wezterm" is on the filename, return false
      if string.find(filename, ".config/wezterm") then
        return nil
      end
      nvim_lsp.util.root_pattern(".luarc.json", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", ".git")(
        filename
      )
    end,
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
  ["ts_ls"] = {
    -- capabilities = capabilities,
    -- handlers = {
    --   ["textDocument/definition"] = function(err, result, method, ...)
    --     return handle_go_to_definition(err, result, method, ...)
    --   end,
    -- },
    root_dir = nvim_lsp.util.root_pattern(".yarn", "package.json", ".git"),
    init_options = {
      maxTsServerMemory = 8192,
    },
  },
  ["tailwindcss"] = {
    capabilities = capabilities,
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            "twc\\.[^`]+`([^`]*)`",
            "twc\\(.*?\\).*?`([^`]*)",
            { "twc\\.[^`]+\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            { "twc\\(.*?\\).*?\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            "twx\\.[^`]+`([^`]*)`",
            "twx\\(.*?\\).*?`([^`]*)",
            { "twx\\.[^`]+\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            { "twx\\(.*?\\).*?\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          },
        },
      },
    },
    on_attach = function(client, bufnr)
      -- defaults
      common_on_attach(false)(client, bufnr)
    end,
  },
}

-- require("typescript-tools").setup({
--   -- handlers = {
--   --   ["textDocument/definition"] = function(err, result, method, ...)
--   --     return handle_go_to_definition(err, result, method, ...)
--   --   end,
--   -- },
--   capabilities = capabilities,
--   root_dir = nvim_lsp.util.root_pattern(".yarn", "package.json", ".git"),
--   on_attach = function(client, bufnr)
--     -- defaults
--     common_on_attach(client, bufnr)
--   end,
--   settings = {
--     -- array of strings("fix_all"|"add_missing_imports"|"remove_unused")
--     -- specify commands exposed as code_actions
--     expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused" },
--   },
-- })

local servers = {
  "pyright",
  "rust_analyzer",
  "tailwindcss",
  "ts_ls",
  "prismals",
  "lua_ls",
  "gopls",
  "clangd",
  "cssls",
  "jsonls",
  "html",
  "sqlls",
  "astro",
  "ruff",
  "eslint",
}

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
})

-- SET UP THE SERVERS  ******* IMPORTANT *******
for _, lsp in pairs(servers) do
  if vim.g.using_coq then
    local coq = require("coq")
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

-- vim.cmd([[ autocmd CursorHold * lua PrintDiagnostics() ]])
--     󰬸 ●
--    
-- vim.cmd([[sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=]])
-- vim.cmd([[sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=]])
-- vim.cmd([[sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=]])
-- vim.cmd([[sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=]])

vim.cmd([[sign define DiagnosticSignError text=● texthl=DiagnosticSignError linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignWarn text=● texthl=DiagnosticSignWarn linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignInfo text=● texthl=DiagnosticSignInfo linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignHint text=● texthl=DiagnosticSignHint linehl= numhl=]])

vim.diagnostic.config({
  underline = false,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
})

_G.cancel_all = function()
  local clients = vim.lsp.buf_get_clients(0)
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
      pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
    end
  end
end

_G.p = function(arg)
  print(vim.inspect(arg))
end

vim.cmd([[nnoremap <leader>lca :lua cancel_all()<CR>]])
