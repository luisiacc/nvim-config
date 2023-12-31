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
local ok, context = pcall(require, "treesitter-context")
if not ok then
  return
end
context.setup({
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
  trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
})


vim.filetype.add({
  extension = {
    mdx = 'mdx'
  }
})

local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
ft_to_parser.mdx = "markdown"
