return {
    'stevearc/conform.nvim',
    event = "BufWritePre",
    opts = {},
    config = function()
        require("conform").setup({
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
    end
}
