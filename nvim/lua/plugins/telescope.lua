return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup({
        pickers = {},
        extensions = {
          fzf = {},
        },
        defaults = {
          path_display = {
            -- 'shorten',
            "truncate",
          },
          mappings = {
            i = {
              ["<C-l>"] = require("telescope.actions.layout").toggle_preview, -- look preview
            },
          },
          preview = {
            hide_on_startup = true,
            timeout = 100, -- 100ms
            filesize_limit = 0.5, -- 500 KB
          },
          layout_config = {
            prompt_position = "top",
            preview_width = 0.65,
            width = 0.95,
            height = 0.85,
          },
          sorting_strategy = "ascending",
        },
      })
      require("telescope").load_extension("fzf") -- makes telescope faster

      local builtin = require("telescope.builtin")
      local themes = require("telescope.themes")
      local custom = require("plugins.telescope.multigrep")
      local keymap = function(key, func)
        vim.keymap.set("n", key, function()
          func()
        end, { noremap = true, silent = true })
      end

      keymap("<space>F", function()
        builtin.find_files({ cwd = vim.fn.getcwd() })
      end)
      keymap("<space>fb", builtin.buffers)
      keymap("<space>fd", function()
        builtin.diagnostics(themes.get_ivy({
          severity = 1,
          cwd = vim.fn.getcwd(),
        }))
      end)
      keymap("<space>ff", builtin.current_buffer_fuzzy_find)
      keymap("<space>fg", function()
        custom.live_multigrep({ preview = { hide_on_startup = false } })
      end)
      keymap("<space>fh", builtin.help_tags)
      keymap("<space>ft", builtin.treesitter)

      -- keymap("<space>fk", function() -- find keymaps
      --   builtin.keymaps(themes.get_dropdown({
      --     previewer = false,
      --     layout_config = {
      --       width = 0.8,
      --       height = 0.6,
      --     },
      --   }))
      -- end)
    end,
  },
}
