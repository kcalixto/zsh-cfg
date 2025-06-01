return {
  {
    'stevearc/conform.nvim',

    event = "BufWritePre",
    opts = {},
    config = function()
      require("conform").setup({
        formatters = {
          gofmt = { timeout_ms = 500 },
        },
        formatters_by_ft = {
          javascript = { "prettier", stop_after_first = true },
          scss = { "prettier", stop_after_first = true },
          typescriptreact = { "prettier", stop_after_first = true },
          go = { "goimports", "gofmt" },
          rust = { "rustfmt" },
          python = { "black" },
          cpp = { "clang-formatter" },
          lua = { "stylua" },
          ["*"] = { "codespell" },
        },
        format_on_save = false,
      })
    end
  },
}
