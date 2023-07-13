vim.g.autocomplete_tool = "cmp"
vim.g.using_coq = vim.g.autocomplete_tool == "coq"
vim.g.using_cmp = vim.g.autocomplete_tool == "cmp"

local projects
if vim.fn.has("win32") == 1 then
  projects = "C:\\projects\\"
else
  projects = "/Users/Luis/projects/"
end

local function req(name)
  return function()
    pcall(require, name)
  end
end

local plugins = {
  { "stevearc/dressing.nvim", config = req("acc_plugs.dressing") },

  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  { "nvim-telescope/telescope.nvim", config = req("acc_plugs.telescope") },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "nvim-telescope/telescope-project.nvim",
  "tami5/sqlite.lua",
  "nvim-telescope/telescope-frecency.nvim",
  -- { "github/copilot.vim", config = req("acc_plugs.copilot") },
  { "zbirenbaum/copilot.lua", config = req("acc_plugs.copilotlua") },

  {
    "junegunn/fzf",
    build = function()
      vim.cmd("call fzf#install()")
    end,
  },
  "junegunn/fzf.vim",
  { "lewis6991/gitsigns.nvim", config = req("acc_plugs.gitsigns"), event = "BufRead" },
  {
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup({})
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

  --python
  "tweekmonster/django-plus.vim",
  "MunifTanjim/nui.nvim",
  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      window = {
        backdrop = 0,
        width = 170,
      },
    },
    config = function()
      vim.keymap.set("n", "<F9>", ":ZenMode<CR>")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    config = req("acc_plugs.nvim-treesitter"),
    dependencies = {
      "haringsrob/nvim_context_vt",
      "nvim-treesitter/nvim-treesitter-context",
      "RRethy/nvim-treesitter-endwise",
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/playground",
    },
  },
  { "folke/todo-comments.nvim", config = req("acc_plugs.todo-comments") },
  "SmiteshP/nvim-navic",
  { "smjonas/inc-rename.nvim", config = req("acc_plugs.inc_rename") },
  {
    "neovim/nvim-lspconfig",
    config = req("acc_plugs.nvim-lspconfig"),
    dependencies = {
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      "jose-elias-alvarez/null-ls.nvim",
      "williamboman/mason.nvim",
      "simrat39/rust-tools.nvim",
      "dcampos/nvim-snippy",
    },
  },

  { "williamboman/mason.nvim", lazy = false, dependencies = {
    "williamboman/mason-lspconfig.nvim",
  } },

  -- debugger
  {
    "mfussenegger/nvim-dap",
    config = req("acc_plugs.nvim-dap"),
    lazy = true,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      -- debugger langs
      "mfussenegger/nvim-dap-python",
    },
  },

  { "nvim-pack/nvim-spectre", config = req("acc_plugs.nvim-spectre") },

  -- {'ms-jpq/coq_nvim', branch='coq'},
  -- {'ms-jpq/coq.artifacts', branch= 'artifacts'},
  -- {'ms-jpq/coq.thirdparty', branch= '3p'},

  { "dcampos/nvim-snippy", config = req("acc_plugs.nvim-snippy"), dependencies = {
    "honza/vim-snippets",
  } },
  "onsails/lspkind-nvim",

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      "dcampos/cmp-snippy",
    },
    config = req("acc_plugs.nvim-cmp"),
  },
  { "windwp/nvim-autopairs", config = req("acc_plugs.nvim-autopairs"), event = "InsertEnter" },

  { "vim-test/vim-test", config = req("acc_plugs.vim-test") },

  "ggandor/lightspeed.nvim",
  { "mg979/vim-visual-multi", branch = "master" },
  { "sindrets/diffview.nvim", config = req("acc_plugs.diffview"), dependencies = {
    "nvim-lua/plenary.nvim",
  } },
  { "numToStr/Comment.nvim", event = "InsertEnter", config = req("acc_plugs.comment"), lazy = true },

  "ludovicchabant/vim-gutentags",

  "tpope/vim-dadbod",
  "tpope/vim-surround",
  "tpope/vim-repeat",
  { "tpope/vim-fugitive", config = req("acc_plugs.vim-fugitive") },
  "tpope/vim-markdown",

  -- { "lukas-reineke/indent-blankline.nvim", config = req("acc_plugs.indent-blankline") },
  "skywind3000/asyncrun.vim",

  { "norcalli/nvim-colorizer.lua", config = req("acc_plugs.nvim-colorizer") },

  { dir = projects .. "gruvbox-baby" },
  { dir = projects .. "the-matrix-theme" },
  { dir = projects .. "handmade-hero-theme.nvim" },

  -- {
  --   "lmburns/kimbox",
  --   opts = {
  --     toggle_style_key = "<Leader>k",
  --   },
  -- },
  "rktjmp/lush.nvim",

  "briones-gabriel/darcula-solid.nvim",
  "tanvirtin/monokai.nvim",

  { "tjdevries/colorbuddy.nvim", branch = "dev" },
  "jesseleite/nvim-noirbuddy",

  -- colorschemes
  "arcticicestudio/nord-vim",
  "olivercederborg/poimandres.nvim",
  "kaiuri/nvim-juliana",
  { "catppuccin/nvim", name = "catppuccin" },
  -- Plug 'Mofiqul/dracula.nvim'
  "EdenEast/nightfox.nvim",
  "cpea2506/one_monokai.nvim",
  "sainnhe/edge",
  "bluz71/vim-nightfly-guicolors",

  "folke/tokyonight.nvim",
  "Mofiqul/vscode.nvim",

  "projekt0n/github-nvim-theme",
  { "rose-pine/neovim", name = "rose-pine" },
  "sainnhe/gruvbox-material",
  "yazeed1s/oh-lucy.nvim",
  "tiagovla/tokyodark.nvim",
  "ofirgall/ofirkai.nvim",
  "ellisonleao/gruvbox.nvim",

  "kyazdani42/nvim-web-devicons",
  { "kyazdani42/nvim-tree.lua", config = req("acc_plugs.nvim-tree") },
  {
    "feline-nvim/feline.nvim",
    config = req("acc_plugs.feline"),
    dependencies = {
      { dir = projects .. "gruvbox-baby" },
    },
  },

  { "mhinz/vim-startify", config = req("acc_plugs.vim-startify") },
  { "akinsho/toggleterm.nvim", config = req("acc_plugs.toggleterm") },
  { "ThePrimeagen/harpoon", config = req("acc_plugs.harpoon") },
  "ThePrimeagen/refactoring.nvim",
  "Rawnly/gist.nvim",
}

if not vim.g.neovide then
  -- concat something to plugins table
  table.insert(plugins, { "folke/noice.nvim", config = req("acc_plugs.noice"), event = "VeryLazy" })
end

return plugins
