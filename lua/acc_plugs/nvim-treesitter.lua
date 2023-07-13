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
require("treesitter-context").setup({
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

require("nvim_context_vt").setup({
  -- Enable by default. You can disable and use :NvimContextVtToggle to maually enable.
  -- Default: true
  enabled = true,

  -- Override default virtual text prefix
  -- Default: '-->'
  -- prefix = "",
  prefix = "❯",

  -- Override the internal highlight group name
  -- Default: 'ContextVt'
  highlight = "GitSignsCurrentLineBlame",

  -- Disable virtual text for given filetypes
  -- Default: { 'markdown' }
  disable_ft = { "markdown" },

  -- Disable display of virtual text below blocks for indentation based languages like Python
  -- Default: false
  disable_virtual_lines = false,

  -- Same as above but only for spesific filetypes
  -- Default: {}
  disable_virtual_lines_ft = { "yaml" },

  -- How many lines required after starting position to show virtual text
  -- Default: 1 (equals two lines total)
  min_rows = 1,

  -- Same as above but only for spesific filetypes
  -- Default: {}
  min_rows_ft = {},

  -- Custom virtual text node parser callback
  -- Default: nil
  -- custom_parser = function(node, ft, opts)
  --   local utils = require("nvim_context_vt.utils")
  --
  --   -- If you return `nil`, no virtual text will be displayed.
  --   if node:type() == "function" then
  --     return nil
  --   end
  --
  --   -- This is the standard text
  --   return "--> " .. utils.get_node_text(node)[1]
  -- end,

  -- Custom node validator callback
  -- Default: nil
  -- custom_validator = function(node, ft, opts)
  --   -- Internally a node is matched against min_rows and configured targets
  --   local default_validator = require("nvim_context_vt.utils").default_validator
  --   if default_validator(node, ft) then
  --     -- Custom behaviour after using the internal validator
  --     if node:type() == "function" then
  --       return false
  --     end
  --   end
  --
  --   return true
  -- end,

  -- Custom node virtual text resolver callback
  -- Default: nil
  custom_resolver = function(nodes, ft, opts)
    -- By default the last node is used
    return nodes[#nodes]
  end,
})
