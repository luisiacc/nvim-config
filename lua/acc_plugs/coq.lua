local function border(hl_name)
  return {
    { "╭", hl_name },
    { "-", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╛", hl_name },
    { "═", hl_name },
    { "╘", hl_name },
    { "│", hl_name },
  }
end

vim.g.coq_settings = {
  auto_start = "shut-up",
  clients = {
    tree_sitter = { enabled = false },
    tmux = { enabled = false },
    tags = { enabled = false },
  },
  display = {
    pum = {
      fast_close = false,
    },
    preview = {
      border = border("CmpBorder"),
    },
  },
  keymap = {
    bigger_preview = nil,
    jump_to_mark = "<c-g>",
  },
}

require("lspkind").init({
  mode = "symbol_text",
  preset = "codicons",
})

require("coq_3p")({
  { src = "nvimlua", short_name = "nLUA", conf_only = true },
  { src = "bc", short_name = "MATH" },
})

require("coq")
