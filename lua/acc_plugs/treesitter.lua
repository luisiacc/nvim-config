require("nvim-ts-autotag").setup({
  filetypes = {
    "html",
    "htmldjango",
    "javascript",
    "javascript.tsx",
    "javascriptreact",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "svelte",
    "vue",
  },
})
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
  indent = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },
})

require("treesitter-context.config").setup({
  enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
})
