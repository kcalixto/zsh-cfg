return {
  "chrisgrieser/nvim-origami",
  event = "VeryLazy",
  opts = {
    foldtext = {
      lineCount = {
        template = " %d",
      },
    },
  },
  init = function()
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
  end,
}
