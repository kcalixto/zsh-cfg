local lsp = vim.lsp

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'gopls',
    'html',
    'jsonls',
    'lua_ls',
    'tailwindcss',
    -- 'cspell', -- not working idk why
  }
})

local lspconfig = require('lspconfig')

require('mason-lspconfig').setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      -- capabilities = lsp_capabilities,
    })
  end,
})

lsp.handlers["textDocument/hover"] = lsp.with(
  vim.lsp.handlers.hover, {
    border = "rounded",
    width = 100
  }
)
