require("snippy").setup({
  scopes = {
    typescriptreact = { "typescript" },
    javascriptreact = { "javascript" },
  },
  mappings = {
    is = {
      ["<C-.>"] = "expand_or_advance",
      ["<C-,>"] = "previous",
    },
  },
})
