return {
  { 'projekt0n/github-nvim-theme' },
  {
    'Djancyp/better-comments.nvim',
    enabled = true,
    event = "BufRead",
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
  }
}
