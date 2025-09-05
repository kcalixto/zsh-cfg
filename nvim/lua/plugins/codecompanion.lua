return {
  {
    "olimorris/codecompanion.nvim",
    opts = {
      strategies = {
        -- Change the default chat adapter
        chat = {
          -- adapter = "anthropic",
          adapter = "copilot",
        },
      },
      opts = {
        -- Set debug logging
        log_level = "DEBUG",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
