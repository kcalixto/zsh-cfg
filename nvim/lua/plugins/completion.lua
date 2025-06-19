return {
  {
      'saghen/blink.cmp',
      event = "InsertEnter", -- Load when entering Insert mode
      version = '*',
      opts = {
          keymap = {
              ['<C-y>'] = { 'accept', 'fallback' }, -- ensure enter directly accepts
          },

          appearance = {
              use_nvim_cmp_as_default = false,
              nerd_font_variant = 'mono',
          },

          completion = {
              menu = {
                  auto_show = true,
                  draw = {
                      columns = {
                          { "label",     "label_description", gap = 1 },
                          { "kind_icon", "kind",              gap = 2 },
                      },
                  },
              },
              documentation = {
                  window = {
                      border = "rounded",
                      winblend = 0,
                      max_width = 80,  -- limit max width of the documentation window for better readability
                      max_height = 20, -- limit max height for documentation window
                  },
              },
          },

          signature = {
              enabled = true,
              window = {
                  border = "rounded",
                  winblend = 0,
              },
          },

          sources = {
              default = { 'lsp', 'path', 'buffer' },
              providers = {},
          },
      },
      opts_extend = { "sources.default" }
  },
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
      })
    end
  },
  {
    event = 'BufReadPost',
    'github/copilot.vim',
  },
}
