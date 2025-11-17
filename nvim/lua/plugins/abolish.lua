return {
  "tpope/vim-abolish",
  event = "VeryLazy",
  config = function()
    vim.cmd([[runtime macros/abolish.vim]])
  end,
}
