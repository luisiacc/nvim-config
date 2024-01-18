local o = vim.o
local g = vim.g
local opt = vim.opt

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
opt.wrap = false
o.encoding = "utf-8"
o.cmdheight = 1
o.mouse = "a"
o.synmaxcol = 500
o.foldlevelstart = 20
o.showmode = false
o.signcolumn = "yes"

o.diffopt = "vertical"
opt.equalalways = true

-- o.json_ignore_conceal = 1
-- o.html_ignore_conceal = 1

--open local vimrc first
o.exrc = true
--
o.timeoutlen = 400
o.ttimeoutlen = 0
o.mmp = 2000000

-- opt.guicursor=""
o.scrolloff = 5
o.hidden = true
o.switchbuf = "useopen"
o.errorbells = false
o.cursorline = true
o.autoread = true
o.showcmd = true
o.magic = true
o.expandtab = true
o.clipboard = "unnamedplus"

o.nu = false
o.wrap = false
-- " case-insensitive searching
o.ignorecase = true
-- " but become case-sensitive if you type uppercase characters
o.smartcase = true
o.swapfile = false
o.backup = false
o.writebackup = false
o.undodir = "/Users/Luis/.vim/undodir"
o.undofile = true
o.incsearch = true
o.hlsearch = false

o.updatetime = 100
o.colorcolumn = "120"
o.wildmenu = true
-- o.guitablabel = [[\[%N\]\ %t\ %M"]]
-- set guioptions-=T guioptions-=m

-- " Do NOT yank with x/s
vim.cmd([[nnoremap x "_x]])
opt.completeopt = { "menu", "menuone", "noselect" }
-- o.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }

o.termguicolors = true
if vim.fn.has("nvim") == 1 then
  vim.g.NVIM_TUI_ENABLE_TRUE_COLOR = 1
end
