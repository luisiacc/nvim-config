lua << EOF
    require'nvim-treesitter.configs'.setup {
      highlight = {
        enable = true,              -- false will disable the whole extension
      },
      incremental_selection = {enable = true},
      textobjects = {enable = true},
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false -- Whether the query persists across vim sessions
      }
    }
EOF

" autocmd FileType py,js,json,html,css,python,typescriptreact,typescript,javascriptreact,javascript let b:coc_suggest_disable = 1

" lua << EOF
"   local nvim_lsp = require('lspconfig')
"   local on_attach = function(_, bufnr)
"         require('completion').on_attach()
"         local opts = { noremap=true, silent=true }
"         vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
"         vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
"         vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
"         vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
"         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
"         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
"         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
"         vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
"         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xd', '<cmd>lua vim.lsp.util.show_line_diagostics()<CR>', opts)
"       end
"       local servers = {'pyright', 'tsserver'}
"       for _, lsp in ipairs(servers) do
"         nvim_lsp[lsp].setup {
"           on_attach = on_attach,
"         }
"       end
" EOF

