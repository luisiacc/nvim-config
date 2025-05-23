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
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<C-y>",
        function()
          Snacks.terminal.toggle()
        end,
        desc = "Terminal",
        mode = { "n", "t" },
      },
    },
  },

  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  { "nvim-telescope/telescope.nvim", config = req("acc_plugs.telescope") },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "nvim-telescope/telescope-project.nvim",
  "tami5/sqlite.lua",
  -- "nvim-telescope/telescope-frecency.nvim",
  -- { "github/copilot.vim", config = req("acc_plugs.copilot") },
  -- { "zbirenbaum/copilot.lua", config = req("acc_plugs.copilotlua") },
  { "supermaven-inc/supermaven-nvim", config = req("acc_plugs.supermaven") },
  { "j-hui/fidget.nvim", opts = {} },
  {
    "robitx/gp.nvim",
    config = function()
      local conf = {
        -- For customization, refer to Install > Configuration in the Documentation/Readme
      }
      require("gp").setup(conf)

      -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    opts = {
      provider = "gemini",
      gemini = {
        model = "gemini-2.5-pro-preview-03-25",
        max_tokens = 8192,
      },
      behaviour = {
        auto_apply_diff_after_generation = false,
      },
      windows = {
        ---@type "right" | "left" | "top" | "bottom"
        position = "right", -- the position of the sidebar
        wrap = true, -- similar to vim.o.wrap
        width = 40, -- default % based on available width
        sidebar_header = {
          align = "center", -- left, center, right for title
          rounded = true,
        },
      },
      highlights = {
        diff = {
          current = "DiffDelete",
          incoming = "DiffAdd",
        },
      },
    },
    -- if you want to download pre-built binary, then pass source=false. Make sure to follow instruction above.
    -- Also note that downloading prebuilt binary is a lot faster comparing to compiling from source.
    build = ":AvanteBuild source=false",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      -- {
      --   -- Make sure to setup it properly if you have lazy=true
      --   "MeanderingProgrammer/render-markdown.nvim",
      --   opts = {
      --     file_types = { "markdown", "Avante" },
      --   },
      --   ft = { "markdown", "Avante" },
      -- },
    },
  },
  -- {
  --   "sourcegraph/sg.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = req("acc_plugs.sg"),
  -- },

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
    config = req("acc_plugs.chatgpt"),
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
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    config = req("acc_plugs.nvim-lspconfig"),
    dependencies = {
      "williamboman/mason.nvim",
      "simrat39/rust-tools.nvim",
      "dcampos/nvim-snippy",
      "pmizio/typescript-tools.nvim",
    },
  },

  { "nvimtools/none-ls.nvim" },
  { "nvimtools/none-ls-extras.nvim" },

  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = req("acc_plugs.null-ls"),
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

  { "lukas-reineke/indent-blankline.nvim", main = "ibl", config = req("acc_plugs.indent-blankline") },
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
  { "Mofiqul/vscode.nvim", opts = {
    color_overrides = {
      vscBack = "#131313",
    },
  } },

  "projekt0n/github-nvim-theme",
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "moon", -- auto, main, moon, or dawn
      dark_variant = "moon", -- main, moon, or dawn
      styles = {
        italic = false,
      },
    },
  },
  "sainnhe/gruvbox-material",
  "yazeed1s/oh-lucy.nvim",
  "tiagovla/tokyodark.nvim",
  "ofirgall/ofirkai.nvim",
  "ellisonleao/gruvbox.nvim",
  "marko-cerovac/material.nvim",
  "ptdewey/darkearth-nvim",

  "kyazdani42/nvim-web-devicons",
  { "kyazdani42/nvim-tree.lua", config = req("acc_plugs.nvim-tree") },
  -- {
  --   branch = "v3.x",
  -- config = req("acc_plugs.neotree"),
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --     "MunifTanjim/nui.nvim",
  --     -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  --   },
  -- },
  {
    "feline-nvim/feline.nvim",
    config = req("acc_plugs.feline"),
    dependencies = {
      { dir = projects .. "gruvbox-baby" },
    },
  },

  { "mhinz/vim-startify", config = req("acc_plugs.vim-startify") },
  "yorumicolors/yorumi.nvim",
  { "akinsho/toggleterm.nvim", config = req("acc_plugs.toggleterm") },
  { "ThePrimeagen/harpoon", config = req("acc_plugs.harpoon") },
  { "Shatur/neovim-session-manager", config = req("acc.neovim-session-manager") },
  -- {
  --   "luckasRanarison/nvim-devdocs",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   opts = {},
  -- },
  "ThePrimeagen/refactoring.nvim",
  "Rawnly/gist.nvim",
  { "LunarVim/bigfile.nvim", config = req("acc_plugs.bigfile") },
}

-- concat something to plugins table
-- table.insert(plugins, { "folke/noice.nvim", config = req("acc_plugs.noice"), event = "VeryLazy" })

-- if not vim.fn.has("gui_vimr") then
--   table.insert(plugins, { "haringsrob/nvim_context_vt", config = req("acc_plugs.nvim-context") })
-- end

return plugins
