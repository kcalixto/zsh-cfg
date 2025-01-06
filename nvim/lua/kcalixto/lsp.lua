local lsp = vim.lsp
local mason = require('mason')
local masonlspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')

mason.setup()

masonlspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
    })
  end,
})

lsp.handlers["textDocument/hover"] = lsp.with(
  vim.lsp.handlers.hover, {
    border = "rounded",
    width = 100
  }
)

