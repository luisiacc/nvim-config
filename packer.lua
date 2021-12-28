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
  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim")
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
    config = load_config("telescope"),
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  use("folke/trouble.nvim")

  use("junegunn/fzf")
  use("junegunn/fzf.vim")
  use("andrejlevkovitch/vim-lua-format")
  use("kevinhwang91/nvim-bqf")
  use("lewis6991/gitsigns.nvim")

  use("tweekmonster/django-plus.vim")

  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("romgrk/nvim-treesitter-context")
  use("windwp/nvim-ts-autotag")
  use("nvim-treesitter/playground")
  use("folke/todo-comments.nvim")
  use("SmiteshP/nvim-gps")

  use("ray-x/lsp_signature.nvim")
  use("tami5/lspsaga.nvim")

  use("neovim/nvim-lspconfig")
  use("williamboman/nvim-lsp-installer")
  use("jose-elias-alvarez/nvim-lsp-ts-utils")

  use("jose-elias-alvarez/null-ls.nvim")
  use("nvim-pack/nvim-spectre")

  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-calc")
  use("dcampos/nvim-snippy")
  use("dcampos/cmp-snippy")

  use("onsails/lspkind-nvim")

  use("honza/vim-snippets")

  use("mattn/emmet-vim")
  use("windwp/nvim-autopairs")

  use("vim-test/vim-test")

  use("phaazon/hop.nvim")
  use({ "mg979/vim-visual-multi", branch = "master" })
  use("sindrets/diffview.nvim")

  use("ludovicchabant/vim-gutentags")
  use("junegunn/goyo.vim")

  use("tpope/vim-dadbod")
  use("tpope/vim-surround")
  use("tpope/vim-repeat")
  use("tpope/vim-fugitive")
  use("tpope/vim-commentary")
  use("tpope/vim-markdown")
  use("tpope/vim-dispatch")

  use("skywind3000/asyncrun.vim")

  use("tjdevries/colorbuddy.nvim")

  use("christianchiarulli/nvcode-color-schemes.vim")
  use(projects .. "gruvbox-ts")

  use("ntk148v/vim-horizon")
  use("rakr/vim-one")
  use("sainnhe/edge")
  use({ "kaicataldo/material.vim", branch = "main" })
  use("mhartington/oceanic-next")
  use({ "embark-theme/vim", as = "embark" })
  use("mnishz/colorscheme-preview.vim")
  use("eddyekofo94/gruvbox-flat.nvim")
  use("folke/tokyonight.nvim")
  use("projekt0n/github-nvim-theme")
  use("lourenci/github-colors")

  use("editorconfig/editorconfig-vim")

  use("kyazdani42/nvim-web-devicons")
  use("kyazdani42/nvim-tree.lua")
  use("crispgm/nvim-tabline")
  use("hoob3rt/lualine.nvim")

  use("mhinz/vim-startify")
  use("voldikss/vim-floaterm")

  if packer_bootstrap then
    require("packer").sync()
  end
end)
