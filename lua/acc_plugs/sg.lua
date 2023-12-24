local sg = require("sg")

vim.g.sourcegraph_url = "https://sourcegraph.com"
sg.setup({
  auth_strategy = { "cody-app", "nvim" },
})
