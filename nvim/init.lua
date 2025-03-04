-- leader
vim.g.mapleader = " "
-- locals
local opt = vim.opt
local keymap = vim.keymap
-- is it a best practice or something?
local ns = { noremap = true, silent = true }
-- imports
require('kcalixto.lazy')
require('kcalixto.completion')
require('kcalixto.lsp')
require('kcalixto.colorscheme')
-- idk where to group
opt.shiftwidth = 4
opt.clipboard = 'unnamedplus'
opt.wrap = false
opt.number = true
opt.relativenumber = true
opt.scrolloff = 10
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
-- opt.iskeyword:append("-") -- makes vim take dash as part of the word!!
-- set shell
opt.shell = "zsh"
opt.shellcmdflag = "-i -c" -- -i interative, -c ensures the shell runs the provided command
-- undo history
vim.o.undofile = true
-- avoid all the |hit-enter| prompts caused by file
opt.shortmess:append { A = true }
--
opt.fillchars = { eob = " " }
-- diagnostic
vim.diagnostic.config({
  float = {
    source = 'if_many',
    scope = "cursor",
  },
})
vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.open_float(nil, { focus = true })
end, { desc = "Show diagnostics in a floating window" })

vim.api.nvim_create_user_command("GoGenerate", function()
  local cwd = vim.fn.expand("%:p:h")
  vim.fn.system("cd " .. cwd .. " && go generate")
  vim.notify("go generate executed", vim.log.levels.INFO)
end, { desc = "Run go generate" })

-- keymaps
keymap.set("n", "<space><space>x", "<cmd>source %<CR>", ns)
keymap.set("n", "<space>x", ":.lua<CR>", ns)
keymap.set("v", "<space>x", ":lua<CR>", ns)
--
keymap.set('n', '<C-w>_', '<cmd>vs eadirection=hor<CR>', ns)
--
keymap.set("n", "x", '"_x', ns)                                -- normal mode deletes a single character without copying
--
keymap.set("n", "<leader>sv", "<C-w>v<C-w>l", ns)              -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s<C-w>j", ns)              -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", ns)                    -- spit windows in equal width
keymap.set("n", "<leader>sx", ":close<CR>", ns)                -- close current split window
keymap.set('n', '<C-W><C-l>', ':vertical resize +15<CR>', ns)  -- increment window size
keymap.set('n', '<C-W><C-h>', ':vertical resize -15<CR>', ns)  -- decrement window size
keymap.set('n', '<C-W><C-j>', ':horizontal resize +5<CR>', ns) -- increment window size
keymap.set('n', '<C-W><C-k>', ':horizontal resize -5<CR>', ns) -- decrement window size
-- tabs (dont tell anyone i'm using it)
keymap.set("n", "<leader>to", ":tabnew<CR>", ns)               -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>", ns)             -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>", ns)                 -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>", ns)                 -- go to previous tab
keymap.set("n", "<leader>tt", ":tabedit %<CR>", ns)            -- opens current buffer in another tab (kinda temp fullscreen hack)
--
keymap.set('n', '<Leader><CR>', ':noh<CR>', ns)                -- Clear highlight
--
-- keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', ns)
-- keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', ns)
-- keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', ns)
--
keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', ns)
keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', ns)
--
keymap.set('n', '<leader>+', '<C-a>', ns) -- increment number
keymap.set('n', '<leader>-', '<C-x>', ns) -- decrement number
--
keymap.set('n', '<space>st', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd('J')
  vim.api.nvim_win_set_height(0, 10)
end, ns)
--
keymap.set('n', '<space>r', function()
  vim.cmd('LspRestart')
  vim.notify('lsp restarted', vim.log.levels.INFO)
end, ns)
--
keymap.set('n', '<space><space><space>', 'o<esc>30i<CR><esc>', ns)

--
-- loadfms keybindings
--
-- keymap('n', '<Leader>bd', ':bd<CR>', ns)                                    -- Close buffer
-- keymap("n", "<A-TAB>", "<C-^>", ns)
-- keymap('n', 'Q', '<Nop>', ns)                                               -- Disable ex mode. I dunno what is it
keymap.set('', ']b', ':bnext<CR>', ns)
keymap.set('', '[b', ':bprevious<CR>', ns)
keymap.set('n', '<BS>b', function() -- close buffer and go to next
  local bufnr = vim.fn.bufnr()
  vim.cmd('bnext')
  vim.cmd('bdelete ' .. bufnr)
  vim.notify('buffer ' .. bufnr .. ' closed', vim.log.levels.INFO)
end, ns)
keymap.set('', ']c', ':cnext<CR>', ns)
keymap.set('', '[c', ':cprevious<CR>', ns)

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.textwidth = 35 -- Set line width to 80 characters
    vim.opt_local.wrap = true    -- Enable soft wrapping
  end,
})
--
-- keymap('n', '<Leader>dq', '<C-W>k <C-W>o', ns)    -- Close compare buffs
-- keymap('n', '<Leader>da', ':diffget //2<CR>', ns) -- Get content from left side
-- keymap('n', '<Leader>dl', ':diffget //3<CR>', ns) -- Get content from right side
-- keymap('n', '<Leader>gc', ':Gvdiffsplit!<CR>', ns)
-- keymap('n', '<Leader>gl', ':0GcLog<CR>', ns)

-- keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', ns)
-- keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', ns)

-- TODO command
local rnwinid = -1
local rnbufid = -1
local note_path = vim.fn.expand('$NOTE_PATH/_todo.md') -- precompute to avoid slow execution
local function open_ripnote_path()
  if vim.g.kcalixto_rn_open then
    vim.cmd('wa') -- save all
    vim.g.kcalixto_rn_open = false
    vim.api.nvim_win_close(rnwinid, false)
    rnwinid = -1
    rnbufid = -1
  else
    vim.g.kcalixto_rn_open = true
    vim.cmd.vnew()
    vim.cmd('e ' .. note_path) -- Use the precomputed path
    vim.cmd.wincmd('L')
    vim.api.nvim_win_set_width(0, 45)
    rnwinid = vim.fn.win_getid()
  end
end
vim.api.nvim_create_user_command("Rn", open_ripnote_path, { desc = "Run ripnote" })
vim.keymap.set('n', '<leader>n', ':Rn<CR>', ns)

vim.cmd([[
  syn match CustomLineHighlight /^\/\/ \*.*$/
]])
vim.cmd([[
  highlight CustomLineHighlight guifg=lightgreen
]])
vim.cmd([[
  augroup CustomLineHighlight
    autocmd!
    autocmd BufEnter * syntax match CustomLineHighlight /^\/\/ \*.*$/
  augroup END
]])
