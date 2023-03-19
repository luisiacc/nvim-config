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

-- local parsers_path = "/home/acc/.local/share/nvim-treesitter-parsers/"
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
    "help",
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
  indent = { enable = true, disable = { "python" } },
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
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- termcolors = {} -- table of colour name strings
  },
})

-- vim.opt.runtimepath:append(parsers_path)
