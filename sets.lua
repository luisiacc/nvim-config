vim.o.encoding = "utf-8"
vim.o.mouse = "a"
vim.o.synmaxcol = 500
vim.o.foldlevelstart = 20
vim.o.showmode = false
vim.o.signcolumn = "yes"

vim.opt.diffopt = "vertical"

-- vim.o.json_ignore_conceal = 1
-- vim.o.html_ignore_conceal = 1

--open local vimrc first
-- vim.opt.exrc = true
--
vim.opt.timeoutlen = 400
vim.opt.ttimeoutlen = 0
vim.opt.mmp = 2000000

-- " set guicursor=
vim.opt.scrolloff = 5
vim.opt.hidden = true
vim.opt.switchbuf = "useopen"

vim.opt.errorbells = false
vim.opt.cursorline = true
vim.opt.autoread = true
vim.opt.showcmd = true
vim.opt.magic = true
vim.opt.expandtab = true
vim.o.clipboard = "unnamedplus"

vim.opt.nu = false
vim.opt.wrap = false
-- " case-insensitive searching
vim.opt.ignorecase = true
-- " but become case-sensitive if you type uppercase characters
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undodir = "~/.vim/undodir"
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.linespace = 10
vim.o.t_Co = 256
vim.o.t_ut = ""
vim.o.t_u7 = ""
vim.o.t_md = ""

vim.opt.updatetime = 100
vim.opt.colorcolumn = "120"
vim.opt.wildmenu = true
vim.opt.guitablabel = [[\[%N\]\ %t\ %M"]]
-- set guioptions-=T guioptions-=m

-- " Do NOT yank with x/s
vim.cmd([[nnoremap x "_x]])
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- vim.o.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }

vim.opt.termguicolors = true
if vim.fn.has("nvim") then
  vim.g.NVIM_TUI_ENABLE_TRUE_COLOR = 1
end
