return {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  root_markers = { 'eslint.config.mjs', 'package.json', '.git' },
  init_options = {
      hostInfo = 'neovim'
  },
  settings = {
    enabled = true,
    packageManager = 'npm',
    codeActionOnSave = {
      enable = true,
      rules = { "!debugger", "!no-only-tests/*" },
      mode = 'all', -- 'all' | 'problems' | 'suggestions' | 'layout'
    },
    format = { enabled = true },
    lintTask = { enable = true },
  },
}
