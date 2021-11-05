lua << EOF
require('todo-comments').setup{}
--require('nvim-ts-autotag').setup()
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
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
    enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
}

-- ▌ cool font
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '▍', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '▍', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '▍', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '▍', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '▍', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  numhl = false,
  linehl = false,
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <leader>sc'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>sc'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>uc'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>uc'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>ci'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
  watch_index = {
    interval = 1000,
    follow_files = true
  },
  current_line_blame = true,
  current_line_blame_opts = {
      delay = 200,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  word_diff = false,
  diff_opts = {
    internal = true,
  },
}

require('nvim-gps').setup({
	  icons = {
        ["class-name"] = ' ',      -- Classes and class-like objects
        ["function-name"] = ' ',   -- Functions
        ["method-name"] = ' '      -- Methods (functions inside class-like objects)
	},
	adlanguages = {                    -- You can disable any language individually here
        ["c"] = true,
        ["cpp"] = true,
        ["go"] = true,
        ["java"] = true,
        ["javascript"] = true,
        ["lua"] = true,
        ["python"] = true,
        ["rust"] = true,
        ["viml"] = true,
    },
	  separator = ' > ',
})

require'hop'.setup()
vim.opt.listchars:append({lead="·"})
EOF

nnoremap <F4> :lua package.loaded.luisiacc = nil<CR>:source ~/.config/nvim/init.vim<CR>

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
let g:indent_blankline_char = '│'
set list listchars=space:·,trail:~
"char = '·",
" let g:indent_blankline_space_char = '·'
let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:indent_blankline_show_first_indent_level = v:false
let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_buftype_exclude = [ 'terminal', 'telescope' ]
let g:indent_blankline_filetype_exclude = [ 'help', 'startify', 'dashboard', 'packer', 'neogitstatus', 'NvimTree', 'Trouble' ]
let g:indent_blankline_context_patterns = [ 'def', 'class', 'return', 'function', 'method', '^if', '^while', 'jsx_element', '^for', '^object', '^table', 'block', 'arguments', 'if_statement', 'else_clause', 'jsx_element', 'jsx_self_closing_element', 'try_statement', 'catch_clause', 'import_statement', 'operation_type' ]
