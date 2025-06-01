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
        defaults = {
          path_display = {
            -- 'shorten',
            'smart',
          },
          mappings = {
            i = {
              ['<C-l>'] = require('telescope.actions.layout').toggle_preview, -- look preview
            }
          },
          preview = {
            hide_on_startup = true,
            timeout = 100,        -- 100ms
            filesize_limit = 0.5, -- 500 KB
          },
          layout_config = {
            prompt_position = 'top',
            preview_width = 0.65,
            width = 0.95,
            height = 0.85,
          },
          sorting_strategy = 'ascending',
        },
      }
      require('telescope').load_extension('fzf') -- makes telescope faster

      local builtin = require('telescope.builtin')
      local themes = require('telescope.themes')
      local custom = require('kcalixto.plugins.telescope.multigrep')

      vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = '#e9537a' })
      vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { fg = '#a7acc7' })

      vim.keymap.set('n', '<space>fh', function() builtin.help_tags() end, { desc = "Find help tags" })
      -- vim.keymap.set('n', '<space>F', function() builtin.git_files({ cwd = vim.fn.getcwd() }) end)
      vim.keymap.set('n', '<space>F', function() builtin.find_files({ cwd = vim.fn.getcwd() }) end, { desc = "Find files" })
      vim.keymap.set('n', '<space>fg', function() custom.live_multigrep({ preview = { hide_on_startup = false } }) end, { desc = "Live multigrep" })
      vim.keymap.set('n', '<space>ft', function() builtin.treesitter() end, { desc = "Find treesitter symbols" })
      vim.keymap.set('n', '<space>fb', function() builtin.buffers() end, { desc = "Find buffers" })
      vim.keymap.set('n', '<space>fd', function()
        builtin.diagnostics(themes.get_ivy({
          severity = 1,
          cwd = vim.fn.getcwd(),
        }))
      end, { desc = "Find diagnostics" })
      -- list keybinds
      vim.keymap.set('n', '<space>fk', function()
        builtin.keymaps(themes.get_dropdown({
          previewer = false,
          layout_config = {
            width = 0.8,
            height = 0.6,
          },
        }))
      end, { desc = "Find keymaps" })
    end,
  },
}
