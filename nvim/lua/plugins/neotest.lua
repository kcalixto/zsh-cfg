return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      -- default
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    -- stylua: ignore
    keys = {
      { "<leader>tr", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
      { "<leader>tR", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
      { "<leader>ti", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
    },
    config = function()
      require("neotest").setup({
        log_level = vim.log.levels.DEBUG,
        adapters = {
          -- require("neotest-vitest"),
          require("neotest-jest"),
          require("neotest-go"),
        },
      })
    end,
  },
  {
    "andythigpen/nvim-coverage",
    version = "*",
    config = function()
      require("coverage").setup({
        auto_reload = true,
      })
    end,
  },
  -- neotest adapters
  {
    "marilari88/neotest-vitest",
    version = "*", -- Optional, but recommended
    config = function() end,
  },
  {
    "nvim-neotest/neotest-jest",
    version = "*", -- Optional, but recommended
    config = function() end,
  },
  {
    "nvim-neotest/neotest-go",
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
    end,
  },
}
