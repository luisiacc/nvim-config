-- require("dap").setup()
require("dapui").setup()
require("nvim-dap-virtual-text").setup()

require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.keymap.set("n", "<F1>", dap.continue, { silent = true })
vim.keymap.set("n", "<F2>", dap.step_over, { silent = true })
vim.keymap.set("n", "<F3>", dap.step_into, { silent = true })
vim.keymap.set("n", "<F4>", dap.step_out, { silent = true })

vim.keymap.set("n", "<leader>db", require("dap").toggle_breakpoint, { silent = true })
vim.keymap.set("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { silent = true })

-- Adapters
dap.adapters.firefox = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/tools/vscode-firefox-debug/dist/adapter.bundle.js" },
}

dap.configurations.typescript = {
  name = "Debug with Firefox",
  type = "firefox",
  request = "launch",
  reAttach = true,
  url = "http://localhost:3000",
  webRoot = "${workspaceFolder}",
  firefoxExecutable = "/usr/bin/firefox",
}

dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/tools/vscode-chrome-debug/out/src/chromeDebug.js" }, -- TODO adjust
}

dap.configurations.javascriptreact = { -- change this to javascript if needed
  {
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}",
  },
}

dap.configurations.typescriptreact = { -- change to typescript if needed
  {
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}",
  },
}
