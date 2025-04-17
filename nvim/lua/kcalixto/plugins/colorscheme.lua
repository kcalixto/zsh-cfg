return {
  {
    'Djancyp/better-comments.nvim',
    enabled = true,
    config = function()
      require('better-comment').Setup {
        tags = {
          {
            name = "TODO",
            fg = "white",
            bg = "#0a7aca",
            bold = false,
            virtual_text = "",
          },
          {
            name = "FIX",
            fg = "white",
            bg = "#f44747",
            bold = false,
            virtual_text = "",
          },
          {
            name = "Warning",
            fg = "#FFA500",
            bg = "",
            bold = false,
            virtual_text = "",
          },
          {
            name = "WARNING",
            fg = "#FFA500",
            bg = "",
            bold = false,
            virtual_text = "",
          },
          {
            name = "!",
            fg = "#f44747",
            bg = "",
            bold = false,
            virtual_text = "",
          },
          {
            name = "*",
            fg = "#9bc98d",
            bg = "",
            bold = false,
            virtual_text = "",
          },
          {
            name = "?",
            fg = "white",
            bg = "#0a7aca",
            bold = false,
            virtual_text = "",
          }
        }
      }
    end
  },
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  }
}
