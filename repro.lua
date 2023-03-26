-- DO NOT change the paths and don't remove the colorscheme
local root = vim.fn.fnamemodify("./.repro", ":p")
-- set stdpaths to use .repro
for _, name in ipairs({ "config", "data", "state", "cache" }) do
  vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
end

-- bootstrap lazy
local lazypath = root .. "/plugins/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.runtimepath:prepend(lazypath)

-- install plugins
local plugins = {
  "folke/tokyonight.nvim",
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
      "windwp/nvim-ts-autotag",
      -- "p00f/nvim-ts-rainbow",
      "nvim-treesitter/playground",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- parser_install_dir = parsers_path,
        autotag = {
          enable = true,
        },
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
        indent = { enable = true },
        endwise = {
          enable = true,
        },
        -- textobjects = { enable = true },
        additional_vim_regex_highlighting = false,
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
        },
        -- rainbow = {
        --   enable = true,
        --   -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        --   extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        --   max_file_lines = nil, -- Do not enable for files with more than n lines, int
        --   -- termcolors = {} -- table of colour name strings
        -- },
      })
    end,
  },
}
require("lazy").setup(plugins, {
  root = root .. "/plugins",
})

vim.cmd.colorscheme("tokyonight")
