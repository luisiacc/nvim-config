local toggleterm = require("toggleterm")

toggleterm.setup({
  -- size can be a number or function which is passed the current terminal
  size = 20,
  open_mapping = [[<c-m>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  direction = "float",
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = "single",
    -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    -- width = 80,
    -- height = 50,
    winblend = 1,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})
