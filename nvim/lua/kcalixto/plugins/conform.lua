return {
  {
    event = 'VeryLazy',
    'stevearc/conform.nvim',
    opts = {},
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          css = { 'prettier' },
          scss = { 'prettier' },
          go = { 'goimports', 'gofmt' },
          rust = { 'rustfmt' },
          python = { 'black' },
          javascript = { 'prettier' },
          typescript = { 'prettier' },
        },
        -- NOOOOOOO!
        -- format_on_save = {
        --   -- These options will be passed to conform.format()
        --   timeout_ms = 5000,
        --   lsp_fallback = true,
        -- },
      })
    end
  },
}
