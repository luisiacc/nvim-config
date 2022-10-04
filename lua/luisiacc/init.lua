require("luisiacc.telescope")
require("luisiacc.replace")
require("luisiacc.cycle_colorschemes")
local lsp = require("lspconfig")

-- change cwd on buf enter
local function go_to_nearest_git_ancestor()
  local git_ancestor = lsp.util.root_pattern(".git")(vim.api.nvim_buf_get_name(0))
  if git_ancestor then
    vim.cmd("cd " .. git_ancestor)
  end
end
vim.api.nvim_create_user_command("CWD", go_to_nearest_git_ancestor, {})

local group = vim.api.nvim_create_augroup("ChangeCwd", {})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = group,
  callback = function()
    go_to_nearest_git_ancestor()
  end,
})

-- change font with commands
local function use_font(font)
  return function()
    vim.g.gui_font_face = font
    vim.opt.guifont = string.format("%s:h%s", font, vim.g.gui_font_size)
  end
end

vim.api.nvim_create_user_command("LGM", use_font("MesloLGM Nerd Font"), {})
vim.api.nvim_create_user_command("LGL", use_font("MesloLGL Nerd Font"), {})

-- autocmds

vim.api.nvim_create_autocmd("BufRead", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
vim.api.nvim_create_autocmd("BufNewFile", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })

vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.txt", "*.md", "*.tex" }, command = "setlocal spell" }
)

vim.g.last_commit_message = nil

vim.keymap.set("n", "<leader>ac", function()
  vim.ui.input({ prompt = "Commit message" }, function(input)
    if input then
      vim.g.last_commit_message = input
      vim.cmd("G cm " .. '"' .. input .. '"')
    end
  end)
end, { silent = true })

vim.keymap.set("n", "<leader>ar", function()
  vim.ui.input({ prompt = "Commit message", default = vim.g.last_commit_message }, function(input)
    if input then
      vim.g.last_commit_message = input
      vim.cmd("G cm " .. '"' .. input .. '"')
    end
  end)
end, { silent = true })

vim.keymap.set("n", "<leader>e", function()
  vim.ui.input({ prompt = "CMD" }, function(input)
    if input then
      vim.cmd(input)
    end
  end)
end, { silent = true })
