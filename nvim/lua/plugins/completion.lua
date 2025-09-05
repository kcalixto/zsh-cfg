return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter", -- Load when entering Insert mode
    dependencies = {
      "xzbdmw/colorful-menu.nvim",
      "echasnovski/mini.icons",
    },
    version = "*",
    opts_extend = { "sources.default" },
    config = function(_, opts)
      local colorful_menu = require("colorful-menu")
      local mini_icons = require("mini.icons")
      local blink = require("blink.cmp")

      colorful_menu.setup({
        ls = {
          lua_ls = { arguments_hl = "@comment" },
          gopls = {
            align_type_to_right = false,
            add_colon_before_type = true,
            preserve_type_when_truncate = true,
          },
          ts_ls = { extra_info_hl = "@comment" },
          fallback = true,
          fallback_extra_info_hl = "@comment",
        },
        fallback_highlight = "@variable",
        max_width = 0.6, -- between 0 and 1, it'll be treated as percentage of the width of the window
      })

      blink.setup({
        keymap = {
          ["<C-y>"] = { "accept", "fallback" },
        },

        appearance = {
          use_nvim_cmp_as_default = false,
          nerd_font_variant = "mono",
        },

        completion = {
          menu = {
            auto_show = true,
            draw = {
              columns = { -- List of available components: label, label_description, source_name, source_id, kind, kind_icon
                { "kind_icon", gap = 1 },
                { "label", gap = 1 },
                { "kind", gap = 1 },
              },
              components = {
                label = {
                  text = function(ctx)
                    return colorful_menu.blink_components_text(ctx)
                  end,
                  highlight = function(ctx)
                    return colorful_menu.blink_components_highlight(ctx)
                  end,
                },
                kind_icon = {
                  text = function(ctx)
                    local kind_icon, _, _ = mini_icons.get("lsp", ctx.kind)
                    return kind_icon
                  end,
                  -- (optional) use highlights from mini.icons
                  highlight = function(ctx)
                    local _, hl, _ = mini_icons.get("lsp", ctx.kind)
                    return hl
                  end,
                },
                kind = {
                  -- (optional) use highlights from mini.icons
                  highlight = function(ctx)
                    local _, hl, _ = mini_icons.get("lsp", ctx.kind)
                    return hl
                  end,
                },
              },
            },
          },
          documentation = {
            window = {
              border = "rounded",
              winblend = 0,
              max_width = 80, -- limit max width of the documentation window for better readability
              max_height = 20, -- limit max height for documentation window
            },
          },
        },

        signature = {
          enabled = true,
          window = {
            border = "rounded",
            winblend = 0,
          },
        },

        sources = {
          default = { "lsp", "path", "buffer" },
          providers = {},
        },
      })
    end,
  },
  {
    event = "VeryLazy",
    "stevearc/conform.nvim",
  },
  {
    event = "BufReadPost",
    "github/copilot.vim",
    -- change Tab to <C-Tab> to avoid conflict with blink.cmp
    -- config = function()
    --   vim.g.copilot_no_tab_map = true
    --   vim.keymap.set("i", "<M-Tab>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
    -- end,
  },
}
