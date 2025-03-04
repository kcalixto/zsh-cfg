return {
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  { "onsails/lspkind.nvim" },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim", -- colorizer for css edits
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip").setup()
      -- https://github.com/rafamadriz/friendly-snippets/blob/efff286dd74c22f731cdec26a70b46e5b203c619/snippets/go.json
      require("luasnip/loaders/from_vscode").lazy_load()
    end,
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
    event = 'VeryLazy',
    'github/copilot.vim',
    config = function()
      -- vim.g.copilot_no_tab_map = true
      -- vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept(' < CR > ')', { silent = true, expr = true })
    end
  },
}
