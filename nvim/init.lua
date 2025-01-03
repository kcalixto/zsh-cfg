-- leader
vim.g.mapleader = " "
-- locals
local opt = vim.opt
local keymap = vim.keymap
-- is it a best practice or something?
local ns = { noremap = true, silent = true }
-- imports
require('kcalixto.lazy')
require('kcalixto.cmp')
require('kcalixto.lsp')
require('kcalixto.colorscheme')
-- idk where to group
opt.shiftwidth = 4
opt.clipboard = 'unnamedplus'
opt.wrap = false
opt.number = true
opt.relativenumber = true
-- tabs & spacing
opt.tabstop = 4
opt.expandtab = true
opt.autoindent = true
-- search
opt.ignorecase = true
opt.smartcase = true
-- cursor line
opt.cursorline = true
-- appearance
opt.termguicolors = true
opt.signcolumn = "yes"
-- clipboard
opt.clipboard:append("unnamedplus")
-- additional typing config
opt.iskeyword:append("-") -- makes vim take dash as part of the word!!
-- set shell
opt.shell = "zsh"
opt.shellcmdflag = "-i -c" -- -i interative, -c ensures the shell runs the provided command
--
opt.shortmess:append { c = true }
--
opt.fillchars = { eob = " " }

-- keymaps
keymap.set("n", "<space><space>x", "<cmd>source %<CR>", ns)
keymap.set("n", "<space>x", ":.lua<CR>", ns)
keymap.set("v", "<space>x", ":lua<CR>", ns)
--
keymap.set('n', '<C-w>_', '<cmd>vs eadirection=hor<CR>', ns)
--
keymap.set("n", "x", '"_x', ns)                                -- normal mode deletes a single character without copying
--
keymap.set("n", "<leader>sv", "<C-w>v", ns)                    -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", ns)                    -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", ns)                    -- spit windows in equal width
keymap.set("n", "<leader>sx", ":close<CR>", ns)                -- close current split window
keymap.set('n', '<C-W><C-l>', ':vertical resize +15<CR>', ns)  -- increment window size
keymap.set('n', '<C-W><C-h>', ':vertical resize -15<CR>', ns)  -- decrement window size
keymap.set('n', '<C-W><C-j>', ':horizontal resize +5<CR>', ns) -- increment window size
keymap.set('n', '<C-W><C-k>', ':horizontal resize -5<CR>', ns) -- decrement window size
--
keymap.set("n", "<leader>to", ":tabnew<CR>", ns)               -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>", ns)             -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>", ns)                 -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>", ns)                 -- go to previous tab
--
keymap.set('n', '<Leader><CR>', ':noh<CR>', ns)                -- Clear highlight
--
keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', ns)
keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', ns)
keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', ns)
--
keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', ns)
keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', ns)
--
keymap.set('n', '<space>st', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd('J')
  vim.api.nvim_win_set_height(0, 5)
end, ns)

--
-- loadfms keybindings
--
-- keymap('n', '<Leader>bd', ':bd<CR>', ns)                                    -- Close buffer
-- keymap("n", "<A-TAB>", "<C-^>", ns)
-- keymap('n', 'Q', '<Nop>', ns)                                               -- Disable ex mode. I dunno what is it
-- keymap('', ']b', ':bnext<CR>', ns)
-- keymap('', '[b', ':bprevious<CR>', ns)
-- keymap('', ']q', ':cnext<CR>', ns)
-- keymap('', '[q', ':cprevious<CR>', ns)

-- keymap('n', '<Leader>dq', '<C-W>k <C-W>o', ns)    -- Close compare buffs
-- keymap('n', '<Leader>da', ':diffget //2<CR>', ns) -- Get content from left side
-- keymap('n', '<Leader>dl', ':diffget //3<CR>', ns) -- Get content from right side
-- keymap('n', '<Leader>gc', ':Gvdiffsplit!<CR>', ns)
-- keymap('n', '<Leader>gl', ':0GcLog<CR>', ns)

-- keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', ns)
-- keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', ns)
