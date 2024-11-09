------------------------------------------------------------------------------------------
------------------------------- null ls --------------------------------------------------
---
require("mason-null-ls").setup({
  ensure_installed = {
    "stylua",
    "jq",
    "gofmt",
    "sqlformat",
    "ruff",
    "djlint",
    "isort",
    "prettier",
    "prettierd",
  },
})
local null_ls = require("null-ls")
local fmt = null_ls.builtins.formatting
local dg = null_ls.builtins.diagnostics
local ca = null_ls.builtins.code_actions

local _debug = function(content)
  local f = io.open("/Users/Luis/.nvim.debug.log", "a")
  f:write(content .. "\n")
  f.close()
end

local lsputil = require("lspconfig.util")
local root_has_file = function(name)
  local cwd = vim.loop.cwd()
  return lsputil.path.exists(lsputil.path.join(cwd, name))
end

null_ls.setup({
  autostart = true,
  default_timeout = 10000,
  sources = {
    fmt.stylua,
    fmt.gofmt,
    fmt.sqlformat,
    fmt.djlint,
    -- fmt.ruff,
    -- dg.ruff,
    -- fmt.black.with({
    --   prefer_local = ".venv/bin",
    --   args = { "--quiet", "-" },
    --   extra_args = { "--line-length", "120" },
    -- }),
    -- fmt.isort,
    -- fmt.isort.with({
    --   -- condition = function(utils)
    --   -- return root_has_file("pyproject.toml")
    --   -- end,
    --   args = function(params)
    --     local lsputil = require("lspconfig.util")
    --     local root = nvim_lsp.pyright.get_root_dir(params.bufname)
    --     local config = {
    --       "--stdout",
    --     }
    --     if lsputil.path.exists(lsputil.path.join(root, "pyproject.toml")) then
    --       table.insert(config, "--settings-path")
    --       table.insert(config, root)
    --     end
    --     table.insert(config, "--filename")
    --     table.insert(config, "$FILENAME")
    --     table.insert(config, "-")
    --     return config
    --   end,
    -- }),
    -- fmt.prettier.with({
    --   extra_filetypes = { "astro", "mdx" },
    -- }),
		fmt.prisma_format,
    fmt.prettierd.with({
      extra_filetypes = { "astro", "mdx" },
    }),
    -- dg.tsc,
    dg.djlint,
    -- dg.flake8,
    ca.refactoring,
    -- require("none-ls.diagnostics.eslint"),
    -- require("none-ls.formatting.eslint_d"),
    -- require("none-ls.code_actions.eslint"),
  },
})

------------------------------------------------------------------------------------------
