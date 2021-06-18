lua << EOF
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,              -- false will disable the whole extension
        additional_vim_regex_highlighting = true
    },
    indent = {enable = true},
    incremental_selection = {enable = true},
    textobjects = {enable = true},
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false -- Whether the query persists across vim sessions
    }
    }

require'bqf'.setup({
    auto_enable = true,
    preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border_chars = {'┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█'}
    },
    func_map = {
        vsplit = '',
        ptogglemode = 'z,',
        stoggleup = ''
    },
    filter = {
        fzf = {
            extra_opts = {'--bind', 'ctrl-o:toggle-all', '--prompt', '> '}
        }
    }
})

require'treesitter-context.config'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
}
EOF

