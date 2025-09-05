return {
  {
    event = "VeryLazy",
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "nvim-treesitter/nvim-treesitter-context" },
      { "nvim-treesitter/playground" },
      { "OXY2DEV/markview.nvim" },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "go",
          "lua",
          "javascript",
          "html",
          "typescript",
          "css",
          "scss",
          "terraform",
          "tsx",
          "bash",
          "markdown",
          "vim",
          "vimdoc",
          "query",
          "markdown_inline",
        },
        indent = { enable = true },
        auto_install = true,
        sync_install = false,
        highlight = {
          enable = true,
          disable = { "csv" },
        },
        ignore_install = {},
        modules = {},
        --
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      })

      require("treesitter-context").setup({
        enable = true,
        max_lines = 3,
        trim_scope = "outer",
        min_window_height = 20,
        patterns = {
          default = {
            "class",
            "function",
            "method",
            "for",
            "while",
            "if",
            "switch",
            "case",
          },
        },
        zindex = 20,
        mode = "cursor",
        separator = nil,
      })
    end,
  },
}
