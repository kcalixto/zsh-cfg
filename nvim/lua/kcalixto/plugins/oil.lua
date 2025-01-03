vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set('n', '<leader>s',
  function()
    vim.cmd('w') -- same as :w
    vim.notify('File saved successfully', vim.log.levels.INFO)
  end,
  { desc = "Format and save the file" }
)

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
