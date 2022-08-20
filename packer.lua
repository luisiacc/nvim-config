local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

local projects = "/home/acc/projects/"
if vim.fn.has("win32") then
  projects = "C:\\projects\\"
end

local nvim_config_home = "~/.config/nvim"
if vim.fn.has("win32") then
  nvim_config_home = "~/AppData/Local/nvim"
end

local load_config = function(config)
  return function()
    require("acc_plugs" .. config)
  end
end

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")
  use("stevearc/dressing.nvim")
  use("ziontee113/icon-picker.nvim")

  use("vimwiki/vimwiki")
  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim")
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
    config = load_config("telescope"),
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use("nvim-telescope/telescope-file-browser.nvim")
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use("nvim-telescope/telescope-project.nvim")
  use("nvim-telescope/telescope-frecency.nvim")
  use("tami5/sqlite.lua")
  use({ "github/copilot.vim", config = load_config("copilot") })

  use({ "folke/trouble.nvim", config = load_config("trouble") })

  use("junegunn/fzf")
  use("junegunn/fzf.vim")
  use("lewis6991/gitsigns.nvim")

  use("tweekmonster/django-plus.vim")
  use("karb94/neoscroll.nvim")
  use("simrat39/symbols-outline.nvim")

  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("RRethy/nvim-treesitter-endwise")
  use("romgrk/nvim-treesitter-context")
  use("windwp/nvim-ts-autotag")
  use("nvim-treesitter/playground")
  use("folke/todo-comments.nvim")
  use("SmiteshP/nvim-gps")
  use("p00f/nvim-ts-rainbow")

  use("ray-x/lsp_signature.nvim")
  use("tami5/lspsaga.nvim")

  use("neovim/nvim-lspconfig")
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("jose-elias-alvarez/nvim-lsp-ts-utils")
  use("simrat39/rust-tools.nvim")

  use("mfussenegger/nvim-dap")
  use("rcarriga/nvim-dap-ui")
  use("theHamsta/nvim-dap-virtual-text")

  use("mfussenegger/nvim-dap-python")

  use("jose-elias-alvarez/null-ls.nvim")
  use({ "nvim-pack/nvim-spectre", config = load_config("spectre") })

  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-calc")
  use({ "dcampos/nvim-snippy", config = load_config("snippy") })
  use("dcampos/cmp-snippy")

  use("onsails/lspkind-nvim")

  use("honza/vim-snippets")

  use("mattn/emmet-vim")
  use("windwp/nvim-autopairs")

  use("vim-test/vim-test")

  use("ggandor/lightspeed.nvim")
  use({ "mg979/vim-visual-multi", branch = "master" })
  use("sindrets/diffview.nvim")
  use("numToStr/Comment.nvim")

  use("ludovicchabant/vim-gutentags")
  use("folke/zen-mode.nvim")

  use("tpope/vim-dadbod")
  use("tpope/vim-surround")
  use("tpope/vim-repeat")
  use("tpope/vim-fugitive")
  use("tpope/vim-markdown")
  use("tpope/vim-dispatch")

  use("skywind3000/asyncrun.vim")
  use("lukas-reineke/indent-blankline.nvim")

  use("tjdevries/colorbuddy.nvim")
  use("norcalli/nvim-colorizer.lua")

  use(projects .. "gruvbox-ts")
  use("tanvirtin/monokai.nvim")
  use("olivercederborg/poimandres.nvim")
  use("kaiuri/nvim-juliana")
  use({ "catppuccin/nvim", as = "catppuccin", run = "catppuccin" })
  use("lmburns/kimbox")
  use("Mofiqul/dracula.nvim")
  use("EdenEast/nightfox.nvim")
  use("cpea2506/one_monokai.nvim")
  use("ntk148v/vim-horizon")
  use("sainnhe/edge")
  use("bluz71/vim-nightfly-guicolors")
  use("folke/tokyonight.nvim")
  use("Mofiqul/vscode.nvim")
  use("projekt0n/github-nvim-theme")
  use("FrenzyExists/aquarium-vim")
  use({ "rose-pine/neovim", as = "rose-pine" })
  use("sainnhe/gruvbox-material")

  use("editorconfig/editorconfig-vim")

  use("kyazdani42/nvim-web-devicons")
  use("kyazdani42/nvim-tree.lua")
  -- use("hoob3rt/lualine.nvim")
  use("feline-nvim/feline.nvim")

  use("mhinz/vim-startify")
  use("akinsho/toggleterm.nvim")
  use("ThePrimeagen/harpoon")
  use("ThePrimeagen/refactoring.nvim")
  use("rcarriga/nvim-notify")

  if packer_bootstrap then
    require("packer").sync()
  end
end)
