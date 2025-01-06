return {
  'kdheepak/lazygit.nvim',
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  -- optional for floating window border decoration
  dependecies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    {
      '<leader>lg', '<cmd>LazyGit<CR>', desc = 'Open lazy git'
    },
  }
}
