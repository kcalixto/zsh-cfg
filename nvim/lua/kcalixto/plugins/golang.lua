return {
  'ray-x/navigator.lua',
  dependencies = {
    { 'hrsh7th/nvim-cmp' }, { 'nvim-treesitter/nvim-treesitter' },
    { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
    {
      'ray-x/go.nvim',
      ft = { 'go', 'gomod' },
      event = { 'CmdlineEnter' },
      build = ':lua require("go.install").update_all_sync()',
    },
    {
      'ray-x/lsp_signature.nvim',
      event = 'VeryLazy',
      config = function() require('lsp_signature').setup() end,
    },
  },
  config = function()
    require('go').setup()
    require('navigator').setup({
      lsp_signature_help = true,
      lsp = { format_on_save = false },
      icons = { icons = false }, -- default icons are wild
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = 'go',
      callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', '<C-i>', ':GoImport<CR>', {})
        vim.api.nvim_buf_set_keymap(0, 'n', '<C-t>', ':GoTestPkg<CR>', {})
        vim.api.nvim_buf_set_keymap(0, 'n', '<C-c>', ':GoCoverage -p<CR>', {})
      end,
    })
  end
}
