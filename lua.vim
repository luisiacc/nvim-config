lua << EOF
    require'nvim-treesitter.configs'.setup {
      highlight = {
        enable = true,              -- false will disable the whole extension
      },
      incremental_selection = {enable = true},
      textobjects = {enable = true},
      rainbow = {enable = true},
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false -- Whether the query persists across vim sessions
      }
    }
EOF

lua require'tabline'.setup{}
