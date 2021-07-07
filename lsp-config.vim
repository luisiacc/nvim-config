nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" lua require'lspconfig'.pyright.setup{}
" lua require'snippets'.use_suggested_mappings()
" lua require'lsp_signature'.on_attach()

" disable diagnostics for lsp-config
" lua vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
lua vim.lsp.handlers["textDocument/codeLens"] = function() end

function ShowLineDiagnostic() abort
    let line_diagnostics = v:lua.vim.lsp.diagnostic.get_line_diagnostics()
    if v:lua.next(line_diagnostics)
        :echo substitute(line_diagnostics[0].message, "\n", ".", "")
    else
        :echo
    endif
endfunction

autocmd! CursorMoved * :call ShowLineDiagnostic()

lua << EOF

vim.lsp.set_log_level("debug")
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
--capabilities.textDocument.completion.completionItem.resolveSupport = {
 -- properties = {
   -- 'documentation',
 --   'detail',
 --   'additionalTextEdits',
 -- }
--}

require'lspconfig'.clangd.setup{
    capabilities = capabilities,
}

require('lspconfig').jsonls.setup{
    capabilities = capabilities,
}
require('lspconfig').html.setup{
    capabilities = capabilities,
}
require('lspconfig').cssls.setup{
    capabilities = capabilities,
}
require'lspconfig'.vimls.setup{
    capabilities = capabilities,
}
require'lspconfig'.rls.setup{
    capabilities = capabilities,
}

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
nnoremap <silent><leader>gd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>

"" jump diagnostic
nnoremap <silent> <leader>ne <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> <leader>pe <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>

"" float terminal also you can pass the cli command in open_float_terminal function
nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>
tnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>
