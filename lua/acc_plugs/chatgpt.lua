require("chatgpt").setup({
  openai_params = {
    model = "gpt-4-1106-preview",
    -- model = "gpt-3.5-turbo",
    frequency_penalty = 0,
    presence_penalty = 0,
    max_tokens = 3000,
    temperature = 0,
    top_p = 1,
    n = 1,
  },
  openai_edit_params = {
    model = "gpt-4-1106-preview",
    -- model = "gpt-3.5-turbo",
    frequency_penalty = 0,
    presence_penalty = 0,
    temperature = 0,
    top_p = 1,
    n = 1,
  },
})
