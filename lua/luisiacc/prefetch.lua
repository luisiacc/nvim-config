local lsp = vim.lsp

local M = {}

M.prefetch_definitions = function()
    local params = {
        textDocument = lsp.util.make_text_document_params()
    }
    lsp.buf_request(0, 'textDocument/documentSymbol', params, function(err, result)
        if err or not result then return end
        for _, symbol in ipairs(result) do
            if symbol.location then
                local def_params = {
                    textDocument = params.textDocument,
                    position = symbol.location.range.start
                }
                lsp.buf_request(0, 'textDocument/definition', def_params, function() end) -- Empty callback to discard results
            end
        end
    end)
end

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        pcall(M.prefetch_symbol)
    end,
})

return M
