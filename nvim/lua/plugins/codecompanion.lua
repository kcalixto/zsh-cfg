return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup()
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
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
        -- extensions = {
        --   mcphub = {
        --     callback = "mcphub.extensions.codecompanion",
        --     opts = {
        --       make_vars = true,
        --       make_slash_commands = true,
        --       show_result_in_chat = true,
        --     },
        --   },
        -- },
      })
    end,
  },
}
