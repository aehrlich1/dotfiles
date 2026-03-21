return {
  { "folke/noice.nvim", enabled = false },
  { "folke/todo-comments.nvim", enabled = false },
  { "L3MON4D3/LuaSnip", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  {
    "folke/snacks.nvim",
    opts = {
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
  },
}
