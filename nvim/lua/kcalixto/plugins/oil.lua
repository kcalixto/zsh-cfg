vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- haha no way it works LOL
local winid = -1
vim.keymap.set('n', '<space>e', function()
  if vim.g.kcalixto_oil_open == true then
    vim.g.kcalixto_oil_open = false
    vim.api.nvim_win_close(winid, false)
  else
    vim.g.kcalixto_oil_open = true -- toggle var hehe

    vim.cmd.vnew() -- new window
    vim.cmd('Oil') -- opens oil of course
    vim.cmd.wincmd('H') -- mv window to far left
    vim.api.nvim_win_set_width(0, 35)
    winid = vim.fn.win_getid() -- saves id for close later
  end
end)

return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      prompt_save_on_select_new_entry = true,
      delete_to_trash = true,
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
      },
    },
    -- Optional dependencies
    -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
  },
}
