return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader><space>",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
  },
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
