return {
  'ray-x/navigator.lua',
  enabled = true,
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
        -- GoCoverage	go test -coverprofile
        -- GoCoverage -p	go test -coverprofile (only tests package for current buffer)
        -- GoCoverage -f coverage_file_name	load coverage file
        -- GoCoverage {flags}	-t : toggle, -r: remove signs, -R remove sings from all files, -m show metrics
        -- GoCoverage {flags} {go test flags}	e.g: GoCoverage -p -coverpkg 'yourpackagename'
      end,
    })
  end
}
