return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "claude_code",
          },
          inline = {
            adapter = "claude_code",
          },
        },
        adapters = {
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {
              -- No API key required here; it extracts your browser/SSO OAuth token automatically
            })
          end,
        },
        opts = { log_level = "DEBUG" },
      })
    end,
  },
}
