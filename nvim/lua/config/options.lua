local opt = vim.opt

vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'preview', 'fuzzy' }
vim.opt.shortmess:append { c = true }
-- tabs & spacing
opt.tabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.shiftwidth = 4
-- search
opt.ignorecase = true
opt.smartcase = true
-- appearance
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.wrap = false
opt.number = true
opt.relativenumber = true
opt.scrolloff = 10
-- configs
vim.g.mapleader = " "
opt.clipboard:append("unnamedplus")
opt.shell = "zsh"
opt.shellcmdflag = "-i -c"        -- -i interative, -c ensures the shell runs the provided command
vim.o.undofile = true
opt.shortmess:append { A = true } -- avoid all the |hit-enter| prompts caused by file
opt.fillchars = { eob = " " }
