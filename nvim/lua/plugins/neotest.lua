return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      -- default
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- adapters
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-jest",
      {
        "fredrikaverpil/neotest-golang",
        version = "*", -- Optional, but recommended
        build = function()
          vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
        end,
        config = function() end,
      },
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
        adapters = {
          require("neotest-vitest"),
          require("neotest-jest"),
          require("neotest-golang"),
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
}
