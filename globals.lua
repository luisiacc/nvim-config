function _G.put(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, "\n"))
  return ...
end

local g = vim.g

function _G.Messages()
  local msgs = vim.api.nvim_exec("messages", true)
  vim.api.nvim_command("tabe")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(msgs, "\n"))
end
