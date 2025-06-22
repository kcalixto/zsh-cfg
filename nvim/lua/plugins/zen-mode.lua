return {
  {
    "folke/zen-mode.nvim",
    config = function()
      local zenmode = require("zen-mode")

      -- vim.api.nvim_set_hl(0, 'ZenBg', { fg = '#e9537a' })
      vim.keymap.set("n", "<C-w>m", function()
        zenmode.toggle({
          backdrop = 0.95,
          window = {
            width = 0.98, -- width of the Zen window
            height = 0.96, -- height of the Zen window
          },
          -- callback where you can add custom code when the Zen window opens
          on_open = function(win)
            vim.cmd("hi NormalNC guibg=#092b4d")
          end,
          -- callback where you can add custom code when the Zen window closes
          on_close = function()
            vim.cmd("hi NormalNC guibg=NONE")
          end,
        })
      end, { noremap = true, silent = true })
    end,
  },
}
