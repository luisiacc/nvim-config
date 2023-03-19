local count = 0
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(ev)
    print("hi")
    count = count + 1
    print(count)
  end,
})
