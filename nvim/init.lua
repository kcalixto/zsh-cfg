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
-- opt.foldmethod = 'indent'
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
    vim.notify("Running go generate at " .. cwd, vim.log.levels.INFO)
    -- change to the directory of the current file
    vim.cmd("lcd " .. cwd)
    -- capture the output of the command
    local output = vim.fn.systemlist("go generate")
    for _, line in ipairs(output) do
        vim.notify(line, vim.log.levels.INFO)
    end
end, { desc = "Run go generate" })

-- keymaps
keymap.set("n", "<space><space>x", "<cmd>source %<CR>", ns)
keymap.set("n", "<space>x", ":.lua<CR>", ns)
keymap.set("v", "<space>x", ":lua<CR>", ns)
--
keymap.set('n', '<C-w>_', '<cmd>vs eadirection=hor<CR>', ns)
--
-- keymap.set("n", "x", '"_x', ns)                                 -- normal mode deletes a single character without copying
--
keymap.set("n", "<leader>sv", "<C-w>v<C-w>l", ns)               -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s<C-w>j", ns)               -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", ns)                     -- spit windows in equal width
keymap.set("n", "<leader>sx", ":close<CR>", ns)                 -- close current split window
keymap.set('n', '<C-W><C-l>', ':vertical resize +15<CR>', ns)   -- increment window size
keymap.set('n', '<C-W><C-h>', ':vertical resize -15<CR>', ns)   -- decrement window size
keymap.set('n', '<C-W><C-j>', ':horizontal resize +10<CR>', ns) -- increment window size
keymap.set('n', '<C-W><C-k>', ':horizontal resize -10<CR>', ns) -- decrement window size

-- this is wild
keymap.set("t", "<Esc>", "<C-\\><C-n>", ns) -- exit terminal with esc
-- navigate with option
keymap.set("n", "<M-h>", "<C-\\><C-n><C-w>h", ns)
keymap.set("n", "<M-j>", "<C-\\><C-n><C-w>j", ns)
keymap.set("n", "<M-k>", "<C-\\><C-n><C-w>k", ns)
keymap.set("n", "<M-l>", "<C-\\><C-n><C-w>l", ns)
keymap.set('n', '<C-w>h', '<Nop>', ns)
keymap.set('n', '<C-w>j', '<Nop>', ns)
keymap.set('n', '<C-w>k', '<Nop>', ns)
keymap.set('n', '<C-w>l', '<Nop>', ns)
-- Resize with arrows
-- keymap.set('n', '<Leader><Up>', ':resize +15<CR>', ns)
-- keymap.set('n', '<Leader><Down>', ':resize -15<CR>', ns)
-- keymap.set('n', '<Leader><Left>', ':vertical resize -15<CR>', ns)
-- keymap.set('n', '<Leader><Right>', ':vertical resize +15<CR>', ns)
-- tabs (dont tell anyone i'm using it)
keymap.set("n", "<leader>to", ":tabnew<CR>", ns)    -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>", ns)  -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>", ns)      -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>", ns)      -- go to previous tab
keymap.set("n", "<leader>tt", ":tabedit %<CR>", ns) -- opens current buffer in another tab (kinda temp fullscreen hack)
--
keymap.set('n', '<Leader><CR>', ':noh<CR>', ns)     -- Clear highlight
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
-- small terminal
keymap.set('n', '<space>st', function()
    -- vim.cmd.split()
    -- vim.cmd.term()
    -- vim.cd.wincmd('J')
    -- vim.api.nvim_win_set_height(0, 10)
    vim.cmd('below 10split | term')
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
local notes_term_buf = -1
local notes_term_win = -1
local note_file = vim.fn.expand('$NOTE_PATH/_todo.md') -- precompute to avoid slow execution

local function Notes()
    local width = 45

    -- If the window exists and is valid, close it
    if notes_term_buf and vim.api.nvim_win_is_valid(notes_term_win) then
        vim.cmd('w ' .. note_file) -- save file
        vim.api.nvim_win_close(notes_term_win, true)
        notes_term_win = -1
        return
    end

    if notes_term_buf and vim.api.nvim_buf_is_valid(notes_term_buf) then
        -- Create a new window on the right
        vim.cmd('botright vertical split')
        -- Resize to specified width
        vim.cmd('vertical resize ' .. width)
        -- Set the window to use our existing buffer
        notes_term_win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(notes_term_win, notes_term_buf)
    else
        -- Create new window and buffer
        vim.cmd('botright vertical new')
        -- Resize to specified width
        vim.cmd('vertical resize ' .. width)

        vim.cmd('e ' .. note_file) -- Use the precomputed path

        -- Store references to the buffer and window
        notes_term_buf = vim.api.nvim_get_current_buf()
        notes_term_win = vim.api.nvim_get_current_win()

        -- Set buffer options
        vim.api.nvim_buf_set_option(notes_term_buf, 'bufhidden', 'hide')
        vim.api.nvim_buf_set_option(notes_term_buf, 'buflisted', false)
    end
end
vim.api.nvim_create_user_command("Notes", Notes, { desc = "Open notes" })
vim.keymap.set('n', '<leader>n', ':Notes<CR>', ns)

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

-- CopyFilePath command
vim.api.nvim_create_user_command("CopyFilePath", function()
    local path = vim.fn.expand('%:p')
    vim.fn.setreg('+', path)
    vim.notify('copied ' .. path, vim.log.levels.INFO)
end, { desc = "Copy file path" })

-- leap
require('leap').create_default_mappings() -- todo: disable this

-- Mock command to open random files so i can test some plugin
vim.api.nvim_create_user_command('Mock', function()
        vim.cmd('e ~/.config/nvim/init.lua')
        vim.cmd.split()
        vim.cmd('e ~/.config/nvim/lua/kcalixto/lsp.lua')
        vim.cmd.split()
        vim.cmd('e ~/.config/nvim/lua/kcalixto/completion.lua')
        vim.cmd.vsplit()
        vim.cmd('e ~/.config/nvim/lua/kcalixto/lazy.lua')
        vim.cmd('below 10split | term')
    end,
    { desc = "Mock files" }
)

-- DeleteHiddenBuffers
vim.api.nvim_create_user_command('DeleteHiddenBuffersForced', function()
    local deleted = 0
    local buffers = vim.api.nvim_list_bufs()

    for _, buf in ipairs(buffers) do
        -- Check if buffer exists and is loaded but not visible in any window
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
            local is_visible = false

            -- Check all windows to see if buffer is visible
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                if vim.api.nvim_win_get_buf(win) == buf then
                    is_visible = true
                    break
                end
            end

            -- If buffer is not visible and not modified, delete it
            if not is_visible and not vim.api.nvim_buf_get_option(buf, 'modified') then
                vim.api.nvim_buf_delete(buf, { force = true })
                deleted = deleted + 1
            end
        end
    end

    vim.notify(deleted .. " hidden buffer(s) deleted", vim.log.levels.INFO)
end, { desc = "Delete hidden buffers" })

-- AI command
local goose_term_buf = nil
local goose_term_win = nil

-- Function to open or toggle a terminal with goose on the right side
function ToggleGooseTerminal()
    local width = 55

    -- If the window exists and is valid, close it
    if goose_term_win and vim.api.nvim_win_is_valid(goose_term_win) then
        vim.api.nvim_win_close(goose_term_win, true)
        goose_term_win = nil
        return
    end

    -- If we have a buffer but no window, create a new window
    if goose_term_buf and vim.api.nvim_buf_is_valid(goose_term_buf) then
        -- Create a new window on the right
        vim.cmd('botright vertical split')
        -- Resize to specified width
        vim.cmd('vertical resize ' .. width)
        -- Set the window to use our existing buffer
        goose_term_win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(goose_term_win, goose_term_buf)
        -- Enter insert mode
        vim.cmd('startinsert')
    else
        -- Create new window and buffer
        vim.cmd('botright vertical new')
        -- Resize to specified width
        vim.cmd('vertical resize ' .. width)
        -- Start goose in a terminal
        -- goose session -n session-name
        -- goose session -r
        -- goose session -r --name session-name
        vim.cmd('terminal goose')
        -- Store references to the buffer and window
        goose_term_buf = vim.api.nvim_get_current_buf()
        goose_term_win = vim.api.nvim_get_current_win()
        -- Enter insert mode
        vim.cmd('startinsert')

        -- Set buffer options for the terminal
        vim.api.nvim_buf_set_option(goose_term_buf, 'bufhidden', 'hide')
        vim.api.nvim_buf_set_option(goose_term_buf, 'buflisted', false)
    end
end

-- Create a user command to call this function
vim.api.nvim_create_user_command('ToggleGooseTerminal', function()
    ToggleGooseTerminal()
end, { desc = "Toggle goose terminal sidebar" })

-- Map it to <leader>ai
vim.api.nvim_set_keymap('n', '<leader>aI', ':ToggleGooseTerminal<CR>', { noremap = true, silent = true })

--
-- CODEX AI Agent command
local codex_term_buf = nil
local codex_term_win = nil

-- Function to open or toggle a terminal with codex on the right side
function ToggleCodexTerminal()
    local width = 55

    -- If the window exists and is valid, close it
    if codex_term_win and vim.api.nvim_win_is_valid(codex_term_win) then
        vim.api.nvim_win_close(codex_term_win, true)
        codex_term_win = nil
        return
    end

    -- If we have a buffer but no window, create a new window
    if codex_term_buf and vim.api.nvim_buf_is_valid(codex_term_buf) then
        -- Create a new window on the right
        vim.cmd('botright vertical split')
        -- Resize to specified width
        vim.cmd('vertical resize ' .. width)
        -- Set the window to use our existing buffer
        codex_term_win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(codex_term_win, codex_term_buf)
        -- Enter insert mode
        vim.cmd('startinsert')
    else
        -- Create new window and buffer
        vim.cmd('botright vertical new')
        -- Resize to specified width
        vim.cmd('vertical resize ' .. width)
        -- Start codex in a terminal
        -- codex session -n session-name
        -- codex session -r
        -- codex session -r --name session-name
        vim.cmd('terminal codex')
        -- Store references to the buffer and window
        codex_term_buf = vim.api.nvim_get_current_buf()
        codex_term_win = vim.api.nvim_get_current_win()
        -- Enter insert mode
        vim.cmd('startinsert')

        -- Set buffer options for the terminal
        vim.api.nvim_buf_set_option(codex_term_buf, 'bufhidden', 'hide')
        vim.api.nvim_buf_set_option(codex_term_buf, 'buflisted', false)
    end
end

-- Create a user command to call this function
vim.api.nvim_create_user_command('ToggleCodexTerminal', function()
    ToggleCodexTerminal()
end, { desc = "Toggle codex terminal sidebar" })

-- Map it to <leader>ai
vim.api.nvim_set_keymap('n', '<leader>ai', ':ToggleCodexTerminal<CR>', { noremap = true, silent = true })
