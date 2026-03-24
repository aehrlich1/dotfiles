return {
  "folke/snacks.nvim",
  opts = {
    indent = {
      indent = {
        char = "▏",
      },
      scope = {
        enabled = false,
      },
    },
    explorer = {
      replace_netrw = false,
    },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          exclude = { ".git" },
        },
      },
    },
  },
}
