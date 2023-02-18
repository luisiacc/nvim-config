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
  ensure_installed = {
    "typescript",
    "javascript",
    "json",
    "json5",
    "python",
    "c",
    "cpp",
    "rust",
    "lua",
    "html",
    "jsdoc",
    "markdown",
    "markdown_inline",
    "bash",
    "jsonc",
    "rst",
    "tsx",
    "css",
    "vim",
    "help",
    "yaml",
    "scss",
    "go",
    "gomod",
  },
  highlight = {
    enable = true,
  },
  indent = { enable = true, disable = { "python" } },
  endwise = {
    enable = true,
  },
  textobjects = { enable = true },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- termcolors = {} -- table of colour name strings
  },
})

-- require("treesitter-context").setup({
--   enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
-- })
