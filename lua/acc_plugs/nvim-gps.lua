require("nvim-gps").setup({
  icons = {
    ["class-name"] = " ", -- Classes and class-like objects
    ["function-name"] = " ", -- Functions
    ["method-name"] = " ", -- Methods (functions inside class-like objects)
    ["container-name"] = "⛶ ", -- Containers (example: lua tables)
    ["tag-name"] = "炙", -- Tags (example: html tags)
  },
  adlanguages = { -- You can disable any language individually here
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
  separator = " ❯ ",
})
