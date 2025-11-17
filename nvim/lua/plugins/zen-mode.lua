return {
  {
    "folke/zen-mode.nvim",
    config = function()
      local zenmode = require("zen-mode")

      -- vim.api.nvim_set_hl(0, 'ZenBg', { bg = '#000000' })
      vim.keymap.set("n", "<C-w>m", function()
        zenmode.toggle({
          window = { width = 0.98, height = 0.88 },
          on_open = function(win)
            vim.api.nvim_win_set_config(win, { border = "rounded" })
          end,
        })
      end, { noremap = true, silent = true })
    end,
  },
}
