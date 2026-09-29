return {
  { "neovim/nvim-lspconfig" },
  -- mason is here just to install LSP servers and formatters
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = { "nvimtools/none-ls.nvim" },
   },
}
