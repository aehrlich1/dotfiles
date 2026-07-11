return {
  -- configure the catppuccin plugin itself
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      flavour = "mocha",
      no_italic = true,
    },
  },

  -- tell LazyVim to actually use it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
