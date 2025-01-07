return {
  {
    event = 'VeryLazy',
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'nvim-treesitter/nvim-treesitter-context' },
      { 'nvim-treesitter/playground' },
    },
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {
          'go', 'lua', 'javascript', 'html', 'typescript',
          'css', 'scss', 'terraform', 'tsx', 'bash',
          'markdown', "vim", "vimdoc", "query", "markdown_inline",
        },
        indent = { enable = true },
        auto_install = true,
        sync_install = false,
        highlight = {
          enable = true,
          disable = { 'csv' },
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
        context = {
          enable = true,
          throttle = true,
        },
      }
    end,
  },
}
