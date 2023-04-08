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
  completion = {
    smart = false,
  },
  weights = {
    proximity = 0.8,
  },
  clients = {
    tree_sitter = { enabled = false },
    tmux = { enabled = false },
    tags = { enabled = false },
    paths = {
      resolution = { "file", "cwd" },
    },
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
    jump_to_mark = "<C-,>",
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
