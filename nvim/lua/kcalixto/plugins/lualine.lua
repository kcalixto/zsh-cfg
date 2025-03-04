return {
  {
    event = 'VeryLazy',
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'horizon',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {},
          always_divide_middle = false,
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', { 'diagnostics', always_visible = true } },
          lualine_c = {
            { 'filename', path = 1, file_status = true, newfile_status = false,
              symbols = {
                modified = '●', -- Text to show when the file is modified.
                readonly = '', -- Text to show when the file is non-modifiable or readonly.
                unnamed = '󰊠', -- Text to show for unnamed buffers.
                newfile = '', -- Text to show for newly created file before first write
              }
            }
          },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        extensions = {}
      }
    end
  },
}
