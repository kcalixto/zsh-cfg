return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      prompt_save_on_select_new_entry = true,
      delete_to_trash = true,
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
      },
      columns = {
        "icon",
        -- "permissions",
        "size",
        -- "mtime",
      },
    },
  },
}
