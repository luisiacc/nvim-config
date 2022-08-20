local ok, bqf = pcall(require, "bqf")

if not ok then
  return {}
end

bqf.setup({
  auto_enable = true,
  preview = {
    win_height = 12,
    win_vheight = 12,
    delay_syntax = 80,
    border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
  },
  func_map = {
    vsplit = "",
    ptogglemode = "z,",
    stoggleup = "",
  },
  filter = {
    fzf = {
      extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
    },
  },
})
