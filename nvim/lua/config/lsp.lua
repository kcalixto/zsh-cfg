local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_null_ls = require("mason-null-ls")
local conform = require("conform")
local lsp = vim.lsp
local diagnostic = vim.diagnostic

mason.setup()

-- LSP configuration
local install_lsp = {
  "clangd",
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "pyright",
  "rust_analyzer",
  "tailwindcss",
  "ts_ls",
  "eslint",
}

lsp.enable(install_lsp)

-- Formatting configuration
local install_formatters = {
  "prettier",
  "goimports",
  "gofmt",
  "black",
  "stylua",
  "codespell",
}
conform.setup({
  default_format_opts = {
    timeout_ms = 5000, -- Default timeout for formatters
    -- lsp_format = "fallback", -- Use LSP formatting as a fallback
  },
  formatters_by_ft = {
    css = { "prettier", stop_after_first = true },
    scss = { "prettier", stop_after_first = true },
    html = { "prettier", stop_after_first = true },
    javascript = { "prettier", stop_after_first = true },
    javascriptreact = { "prettier", stop_after_first = true },
    typescript = { "prettier", stop_after_first = true },
    typescriptreact = { "prettier", stop_after_first = true },

    json = { "prettier", stop_after_first = true },

    go = { "goimports", "gofmt" },

    python = { "black" },

    lua = { "stylua" },

    ["*"] = { "codespell" },
  },
  format_on_save = false,
})

-- Mason installation
mason_lspconfig.setup({
  ensure_installed = install_lsp,
  automatic_installation = true,
})

mason_null_ls.setup({
  ensure_installed = install_formatters,
  automatic_installation = true,
})

-- Diagnostic configuration
diagnostic.config({
    virtual_lines = false,
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      source = 'if_many',
      scope = "cursor",
    },
    signs = {
        text = {
            [diagnostic.severity.ERROR] = "󰅚 ",
            [diagnostic.severity.WARN] = "󰀪 ",
            [diagnostic.severity.INFO] = "󰋽 ",
            [diagnostic.severity.HINT] = "󰌶 ",
        },
    },
})

-- FLoating window configuration
-- "bold": Bold line box.
-- "double": Double-line box.
-- "none": No border.
-- "rounded": Like "single", but with rounded corners ("╭" etc.).
-- "shadow": Drop shadow effect, by blending with the background.
-- "single": Single-line box.
-- "solid": Adds padding by a single whitespace cell.
lsp.util.open_floating_preview = (function(orig)
    return function(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = "solid"
        return orig(contents, syntax, opts, ...)
    end
end)(lsp.util.open_floating_preview)
