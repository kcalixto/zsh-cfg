return {
  {
    event = 'VeryLazy',
    'j-hui/fidget.nvim',
    tag = 'v1.5.0',
    opts = {
      -- options
    },
    config = function()
      require('fidget').setup({
        progress = {
          display = {
            done_icon = '',
            progress_icon = -- Icon shown when LSP progress tasks are in progress
            { pattern = 'grow_vertical', period = 1 },
          },
        },
        notification = {
          window = {
            winblend = 0,
          },
        },
      })
    end,
  },
}
