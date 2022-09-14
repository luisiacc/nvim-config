local function getLines()
  local first = vim.fn.line("w0")
  local last = vim.fn.line("w$")
  return first .. "," .. last
end

local function getCommand()
  return ":" .. getLines() .. [[s/\<<C-r><C-w>\>/]]
end

vim.keymap.set("n", "<leader>rt", getCommand, { expr = true })
