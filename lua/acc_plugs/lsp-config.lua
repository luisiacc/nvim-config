vim.cmd([[nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>]])
vim.cmd([[nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>]])
vim.cmd([[nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>]])
vim.cmd([[nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>]])
-- nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
-- nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
vim.cmd([[nnoremap <silent> <leader>pe <cmd>lua vim.diagnostic.goto_prev()<CR>]])
vim.cmd([[nnoremap <silent> <leader>ne <cmd>lua vim.diagnostic.goto_next()<CR>]])

----------------------------------- CMP ---------------------------------------------------
-- Setup nvim-cmp.
local cmp = require("cmp")
local lspkind = require("lspkind")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local snippy = require("snippy")

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      require("snippy").expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif snippy.can_expand_or_advance() then
        snippy.expand_or_advance()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif snippy.can_jump(-1) then
        snippy.previous()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-n>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t("<Down>"), "n", true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    }),
    ["<C-p>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t("<Up>"), "n", true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    }),
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        utilsnips = "[snip]",
      },
    }),
  },
  sources = cmp.config.sources({
    { name = "snippy", max_item_count = 5 },
    { name = "nvim_lua", max_item_count = 10 },
    { name = "nvim_lsp", max_item_count = 10 },
    { name = "path", max_item_count = 10 },
    { name = "calc", max_item_count = 10 },
  }, { { name = "buffer", max_item_count = 10 } }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

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

-- vim.lsp.set_log_level("trace")
local nvim_lsp = require("lspconfig")
local common_on_attach = function(client)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
end

local ts_utils = require("nvim-lsp-ts-utils")

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
    root_dir = nvim_lsp.util.root_pattern(unpack(python_root_files)),
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = false,
          diagnosticMode = "workspace",
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
          -- library = vim.api.nvim_get_runtime_file("", true),
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
      common_on_attach(client)
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

local lsp_installer = require("nvim-lsp-installer")
-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(server_configurations[server.name] or default_config)
end)

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
  sources = {
    fmt.trim_whitespace.with({
      filetypes = { "text", "sh", "zsh", "yaml", "toml", "make", "conf", "tmux" },
    }),
    fmt.rustfmt,
    fmt.stylua,
    fmt.black.with({ prefer_local = ".venv/bin", extra_args = { "--line-length", "120" } }),
    -- fmt.isort,
    fmt.isort.with({
      -- condition = function(utils)
      -- 	return utils.root_has_file("pyproject.toml")
      -- end,
      args = function(params)
        local lsputil = require("lspconfig.util")
        local cwd = vim.loop.cwd()

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
    dg.tsc,
    dg.eslint,
    dg.flake8,
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
saga.init_lsp_saga()

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

-- require("lsp_signature").setup({
-- 	bind = true,
-- 	hint_enable = false, -- virtual hint enable
-- 	hint_prefix = " ", -- Panda for parameter
-- 	handler_opts = { border = "rounded" },
-- })

-- " lsp provider to find the cursor word definition and reference
vim.cmd([[nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>]])

-- " code action
vim.cmd([[nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>]])
vim.cmd([[vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>]])

-- "" show hover doc
vim.cmd([[nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>]])

-- "" scroll down hover doc or scroll in definition preview
vim.cmd([[nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]])
-- "" scroll up hover doc
vim.cmd([[nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]])

-- "" show signature help
vim.cmd([[nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]])

-- "" rename
vim.cmd([[nnoremap <silent><leader>rn <cmd>lua require('lspsaga.rename').rename()<CR>]])

-- "" preview definition
vim.cmd([[nnoremap <silent><leader>dp <cmd>lua require'lspsaga.provider'.preview_definition()<CR>]])
vim.cmd([[nnoremap <silent><leader>gd <C-]>]])

-- "" jump diagnostic
-- " nnoremap <silent> <leader>ne <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
-- " nnoremap <silent> <leader>pe <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>

-- "" float terminal also you can pass the cli command in open_float_terminal function
vim.cmd([[nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>]])
vim.cmd([[tnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>]])

vim.cmd([[sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=]])

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = false,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
})

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
vim.cmd([[nnoremap <leader>aa :lua cancel_all()<CR>]])
