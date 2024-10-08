require("luisiacc.telescope")
require("luisiacc.replace")
require("ui_session")
require("luisiacc.cycle_colorschemes")
require("dingllm")
require("dingllm-config")
local lsp = require("lspconfig")

-- change cwd on buf enter
local function go_to_nearest_git_ancestor()
  local git_ancestor = lsp.util.root_pattern(".git")(vim.api.nvim_buf_get_name(0))
  if git_ancestor then
    vim.cmd("cd " .. git_ancestor)
  end
end
vim.api.nvim_create_user_command("CWD", go_to_nearest_git_ancestor, {})

vim.api.nvim_create_user_command("Push", function(opts)
  vim.cmd("G push origin HEAD -v " .. opts.args)
end, { nargs = "?" })

vim.api.nvim_create_user_command("Pushf", function(opts)
  vim.cmd("G push -f origin HEAD -v " .. opts.args)
end, { nargs = "?" })

local function execute_range(start, finish)
  for i = start, finish do
    local line = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]
    if line then
      vim.cmd(line)
    end
  end
end

vim.api.nvim_create_user_command("R", function(opts)
  execute_range(opts.line1, opts.line2)
end, { range = true })

local group = vim.api.nvim_create_augroup("ChangeCwd", {})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = group,
  callback = function()
    go_to_nearest_git_ancestor()
  end,
})

-- autocmds

vim.api.nvim_create_autocmd("BufRead", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
vim.api.nvim_create_autocmd("BufNewFile", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })

local cache = {}
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(ev)
    if cache[ev.file] == nil then
      local ok, _ = pcall(vim.treesitter.get_parser)
      cache[ev.file] = ok
    end

    if cache[ev.file] then
      vim.cmd("setlocal syntax=OFF")
    end
  end,
})

vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.txt", "*.md", "*.tex" }, command = "setlocal spell" }
)

vim.g.last_commit_message = nil

vim.keymap.set("n", "<leader>ac", function()
  vim.ui.input({ prompt = "Commit message" }, function(input)
    if input then
      vim.g.last_commit_message = input
      vim.cmd("G cm -a -m " .. '"' .. input .. '"')
    end
  end)
end, { silent = true })

-- vim.keymap.set("n", "<leader>ar", function()
--   vim.ui.input({ prompt = "Commit message", default = vim.g.last_commit_message }, function(input)
--     if input then
--       vim.g.last_commit_message = input
--       vim.cmd("G cm " .. '"' .. input .. '"')
--     end
--   end)
-- end, { silent = true })

vim.keymap.set("n", "<leader>e", function()
  vim.ui.input({ prompt = "CMD" }, function(input)
    if input then
      vim.cmd(input)
    end
  end)
end, { silent = true })

local function reload_module(name)
  package.loaded[name] = nil
  return require(name)
end

-- Create the command
vim.api.nvim_create_user_command("ReloadM", function(opts)
  local module_name = opts.args
  if module_name == "" then
    print("Please provide a module name")
    return
  end

  local success, result = pcall(reload_module, module_name)
  if success then
    print(string.format("Module '%s' reloaded successfully", module_name))
  else
    print(string.format("Failed to reload module '%s': %s", module_name, result))
  end
end, {
  nargs = 1,
  complete = function(ArgLead, CmdLine, CursorPos)
    -- This provides basic completion for loaded modules
    local modules = {}
    for k, _ in pairs(package.loaded) do
      if k:find(ArgLead) == 1 then
        table.insert(modules, k)
      end
    end
    return modules
  end,
})
