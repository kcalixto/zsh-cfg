return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    config = function()
      require('telescope').setup {
        pickers = {},
        extensions = {
          fzf = {}
        },
      }

      require('telescope').load_extension('fzf') -- makes telescope faster

      vim.keymap.set('n', '<space>fh', function()
        local builtin = require('telescope.builtin')
        return builtin.help_tags()
      end)
      vim.keymap.set('n', '<space>fd', function()
        local builtin = require('telescope.builtin')
        return builtin.find_files({
          cwd = vim.fn.getcwd(),
        })
      end)
      -- opens telescope in .config folder
      vim.keymap.set('n', '<space>en',
        function()
          require('telescope.builtin').find_files {
            cwd = vim.fn.stdpath('config')
          }
        end
      )

      -- multigrep custom feature
      require("kcalixto.plugins.telescope.multigrep").setup()
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      }
    }
  },
}
