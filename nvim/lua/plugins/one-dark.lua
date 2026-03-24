return {
  "navarasu/onedark.nvim",
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require("onedark").setup({
      style = "dark",
      transparent = true,
      code_style = {
        comments = "none",
        variable = "none",
      },
      colors = {
        purple = "#d19a66",
        yellow = "#abb2bf",
        cyan = "#abb2bf",
      },
      highlights = {
        SnacksIndent = { fg = "#44484F" },
        SnacksIndentScope = { fg = "#44484F" },
        ["@type"] = { fmt = "none" },
        ["@constructor"] = { fmt = "none" },
        ["@function.builtin"] = { fg = "#8686be", fmt = "none" },
        ["@function.call"] = { fg = "#abb2bf", fmt = "none" },
        ["@function.method.call"] = { fg = "#abb2bf", fmt = "none" },
        ["@variable.member"] = { fmt = "none" },
        ["@variable.parameter"] = { fg = "#abb2bf", fmt = "none" }, -- #bf4d30
        ["@variable.builtin"] = { fg = "#8b588a", fmt = "none" },
        ["@punctuation.bracket"] = { fg = "#ebc275", fmt = "none" },
        ["@property"] = { fmt = "none" },
        ["@constant"] = { fg = "#abb2bf", fmt = "none" },
        ["@module"] = { fmt = "none" },
        ["@label"] = { fmt = "none" },
      },
    })
    require("onedark").load()
  end,
}
