return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require('telescope').setup {
        pickers = {},
        extensions = {
          fzf = {},
        },
      }
      require('telescope').load_extension('fzf') -- makes telescope faster

      local builtin = require('telescope.builtin')
      local custom = require('kcalixto.plugins.telescope.multigrep')

      vim.keymap.set('n', '<space>fh', function() builtin.help_tags() end)
      vim.keymap.set('n', '<space>fd', function() builtin.find_files({ cwd = vim.fn.getcwd() }) end)
      vim.keymap.set('n', '<space>fg', function() custom.live_multigrep() end)
      vim.keymap.set('n', '<space>fn', function() custom.live_multigrep({ cwd = vim.fn.stdpath('config') }) end)
      vim.keymap.set('n', '<space>ft', function() builtin.treesitter() end)
    end,
  },
}
