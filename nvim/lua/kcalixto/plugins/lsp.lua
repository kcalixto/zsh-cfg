return {
  {
    'williamboman/mason.nvim',
    enabled = true,
    build = ':MasonUpdate',
    opts = {
      ensure_installed = {
        'gopls',
        'cspell',
        'eslint-lsp',
        'eslint_d',
        'html-lsp',
        'json-lsp',
        'lua-language-server',
        'prettier',
        'rust-analyzer',
        'tailwindcss-language-server',
        'ts-standard',
        'typescript-language-server',
      },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        dependencies = {
          {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
              library = {
                -- informs to lua that vim is a global variable that exists!
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
              },
            },
          },
        },
      },
    },
    config = function()
      local lspconfig = require('lspconfig')
      local masonlspconfig = require('mason-lspconfig')

      masonlspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
          })
        end,
      })

      lspconfig.gopls.setup({
        on_attach = require('mason-lspconfig').on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        root_dir = require('lspconfig/util').root_pattern('go.work', 'go.mod', '.git'),
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        settings = {
          gopls = {
            completeUnimported = true,
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      })

      lspconfig.lua_ls.setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          },
        }
      })
    end
  },
}
