local hooks = require("ibl.hooks")
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level, { bufnr = 0 })

require("ibl").setup({
  indent = {
    char = "▏",
    tab_char = "▏",
  },
  scope = { enabled = true },
  whitespace = {
    remove_blankline_trail = true,
  },
  exclude = {
    filetypes = {
      "help",
      "alpha",
      "dashboard",
      "neo-tree",
      "Trouble",
      "trouble",
      "lazy",
      "mason",
      "notify",
      "toggleterm",
      "lazyterm",
    },
  },
})

