nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>ne <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <leader>pe <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" lua require'lspconfig'.pyright.setup{}
" lua require'snippets'.use_suggested_mappings()

" disable diagnostics for lsp-config
" lua vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
"

lua << EOF

----------------------------------- CMPE ---------------------------------------------------
  -- Setup nvim-cmp.
  local cmp = require'cmp'
  local lspkind = require('lspkind')

    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = function(fallback)
          if not cmp.select_next_item() then
            if vim.bo.buftype ~= 'prompt' and has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end
        end,
        ['<S-Tab>'] = function(fallback)
          if not cmp.select_prev_item() then
            if vim.bo.buftype ~= 'prompt' and has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end
        end,
    },
    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]",
                utilsnips = "[snip]",
            }
        }
    },
    sources = cmp.config.sources({
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer', keyword_length = 5 },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

    vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
    vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

    local border = {
          {" ", "FloatBorder"},
          {"▔", "FloatBorder"},
          {" ", "FloatBorder"},
          {"▕", "FloatBorder"},
          {" ", "FloatBorder"},
          {"▁", "FloatBorder"},
          {" ", "FloatBorder"},
          {"▏", "FloatBorder"},
    }

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or border
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    vim.lsp.set_log_level("debug")
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = false,
        virtual_text = false,
        signs = true,
        update_in_insert = true,
      }
    )

    local nvim_lsp = require('lspconfig')
    local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'clangd', 'jsonls', 'html', 'cssls', 'vimls' }
    for _, lsp in ipairs(servers) do
      nvim_lsp[lsp].setup {
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 150,
        }
      }
    end

    -- lua server-----------------------------------------------------------------------------
    local system_name
    if vim.fn.has("mac") == 1 then
      system_name = "macOS"
    elseif vim.fn.has("unix") == 1 then
      system_name = "Linux"
    elseif vim.fn.has('win32') == 1 then
      system_name = "Windows"
    else
      print("Unsupported system for sumneko")
    end

    -- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
    local sumneko_root_path = '~/lua-language-server'
    local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    require'lspconfig'.sumneko_lua.setup {
        capabilities = capabilities;
      cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = runtime_path,
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    }
    -- end lua server
    ------------------------------------------------------------------------------------------

    vim.lsp.protocol.CompletionItemKind = {
      ' [text]',
      ' [method]',
      'ƒ [function]',
      ' [constructor]',
      ' [field]',
      ' [variable]',
      ' [class]',
      ' [interface]',
      ' [module]',
      ' [property]',
      ' [unit]',
      ' [value]',
      ' [enum]',
      ' [keyword]',
      '﬌ [snippet]',
      ' [color]',
      ' [file]',
      ' [reference]',
      ' [dir]',
      ' [enummember]',
      ' [constant]',
      ' [struct]',
      '  [event]',
      ' [operator]',
      ' [type]',
    }

    local saga = require'lspsaga'
    saga.init_lsp_saga()

    function PrintDiagnostics()
      local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
      local diagnostics = vim.diagnostic.get(0, {lnum=lnum})
      if vim.tbl_isempty(diagnostics) then
          print("")
          return
      end
      for i, diagnostic in ipairs(diagnostics) do
        print(string.format("%d: %s", i, diagnostic.message))
      end
    end

    vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]

    require'lsp_signature'.setup({
        bind = true,
        hint_enable = true, -- virtual hint enable
        hint_prefix = " ",  -- Panda for parameter
        handler_opts = {
            border = "rounded"
        }
    })
EOF


" lsp provider to find the cursor word definition and reference
nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>

" code action
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>

"" show hover doc
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>

"" scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
"" scroll up hover doc
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

"" show signature help
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>

"" rename
nnoremap <silent><leader>rn <cmd>lua require('lspsaga.rename').rename()<CR>

"" preview definition
nnoremap <silent><leader>dp <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
nnoremap <silent><leader>gd <C-]>

"" jump diagnostic
" nnoremap <silent> <leader>ne <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
" nnoremap <silent> <leader>pe <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>

"" float terminal also you can pass the cli command in open_float_terminal function
nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>
tnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>

sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=

