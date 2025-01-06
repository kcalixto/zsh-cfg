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
    enabled = true,
  },
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
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig .gopls.setup({
        on_attach = require('mason-lspconfig').on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        root_dir = require('lspconfig/util').root_pattern('go.work', 'go.mod', '.git'),
        cmd = { 'gopls'} ,
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

      -- vim.api.nvim_create_autocmd('LspAttach', {
      --   callback = function(args)
      --     local client = vim.lsp.get_client_by_id(args.data.client_id)
      --     if not client then return end
      --
      --     if client:supports_method('textDocument/formatting') then
      --       -- Format the current buffer on save
      --       vim.api.nvim_create_autocmd('BufWritePre', {
      --         buffer = args.buf,
      --         callback = function()
      --           vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
      --         end,
      --       })
      --     end
      --   end,
      -- })
    end
  },
}
