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

-- local parsers_path = "/Users/Luis/.local/share/nvim-treesitter-parsers/"
require("nvim-treesitter.configs").setup({
  -- parser_install_dir = parsers_path,
  ensure_installed = {
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "typescript",
    "javascript",
    "json",
    "json5",
    "hcl",
    "http",
    "scheme",
    "make",
    "python",
    "c",
    "cpp",
    "rust",
    "lua",
    "html",
    "markdown",
    "markdown_inline",
    "bash",
    "jsonc",
    "rst",
    "tsx",
    "css",
    "vim",
    "yaml",
    "scss",
    "go",
    "gomod",
    "graphql",
    "cmake",
  },
  highlight = {
    enable = true,
  },
  indent = { enable = true },
  endwise = {
    enable = true,
  },
  textobjects = { enable = true },
  additional_vim_regex_highlighting = false,
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },
})

-- vim.opt.runtimepath:append(parsers_path)
