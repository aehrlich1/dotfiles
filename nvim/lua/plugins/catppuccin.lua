return {
  -- configure the catppuccin plugin itself
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      flavour = "macchiato",
      no_italic = true,
      custom_highlights = function(colors)
        return {
          -- keep the border line, but match its background to the editor
          -- so there's no darker band around floating windows (e.g. yazi)
          NormalFloat = { bg = colors.base },
          FloatBorder = { bg = colors.base },
        }
      end,
    },
  },

  -- tell LazyVim to actually use it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
}
