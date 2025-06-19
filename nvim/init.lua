--
-- ! locals
--
local opt = vim.opt
local keymap = vim.keymap
local ns = { noremap = true, silent = true }
--
-- ! configs
--
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
vim.diagnostic.config({
  float = {
    source = 'if_many',
    scope = "cursor",
  },
})

--
-- ! imports
-- lazy loading
require('kcalixto.lazy')
require('kcalixto.completion')
require('kcalixto.lsp')
require('kcalixto.colorscheme')
require('leap').create_default_mappings()

--
-- ! keymaps
--
keymap.set("n", "<space><space>x", "<cmd>source %<CR>", ns)
keymap.set("n", "<space>x", ":.lua<CR>", ns)
keymap.set("v", "<space>x", ":lua<CR>", ns)
keymap.set('n', '<C-w>_', '<cmd>vs eadirection=hor<CR>', ns)
keymap.set("t", "<Esc>", "<C-\\><C-n>", ns)     -- exit terminal with esc
keymap.set('n', '<Leader><CR>', ':noh<CR>', ns) -- Clear highlight
-- keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', ns)
-- keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', ns)
-- keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', ns)
keymap.set('n', '<leader>+', '<C-a>', ns) -- increment number
keymap.set('n', '<leader>-', '<C-x>', ns) -- decrement number
keymap.set('n', '<space><space><space>', 'o<esc>30i<CR><esc>', ns)
-- keymap('n', '<Leader>bd', ':bd<CR>', ns)                                    -- Close buffer
-- keymap("n", "<A-TAB>", "<C-^>", ns)
-- keymap('n', 'Q', '<Nop>', ns)                                               -- Disable ex mode. I dunno what is it
keymap.set('', ']b', ':bnext<CR>', ns)
keymap.set('', '[b', ':bprevious<CR>', ns)
keymap.set('', ']c', ':cnext<CR>', ns)
keymap.set('', '[c', ':cprevious<CR>', ns)
-- keymap('n', '<Leader>dq', '<C-W>k <C-W>o', ns)    -- Close compare buffs
-- keymap('n', '<Leader>da', ':diffget //2<CR>', ns) -- Get content from left side
-- keymap('n', '<Leader>dl', ':diffget //3<CR>', ns) -- Get content from right side
-- keymap('n', '<Leader>gl', ':0GcLog<CR>', ns)
-- keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', ns)
-- keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', ns)
-- tabs (dont tell anyone i'm using it)
keymap.set("n", "<leader>to", ":tabnew<CR>", ns)    -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>", ns)  -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>", ns)      -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>", ns)      -- go to previous tab
keymap.set("n", "<leader>t1", ":tabn 1<CR>", ns)    -- go to first tab
keymap.set("n", "<leader>t2", ":tabn 2<CR>", ns)    -- go to second tab
keymap.set("n", "<leader>t3", ":tabn 3<CR>", ns)    -- go to third tab
keymap.set("n", "<leader>t4", ":tabn 4<CR>", ns)    -- go to fourth tab
keymap.set("n", "<leader>t5", ":tabn 5<CR>", ns)    -- go to fifth tab
keymap.set("n", "<leader>t6", ":tabn 6<CR>", ns)    -- go to sixth tab
keymap.set("n", "<leader>t7", ":tabn 7<CR>", ns)    -- go to seventh tab
keymap.set("n", "<leader>t8", ":tabn 8<CR>", ns)    -- go to eighth tab
keymap.set("n", "<leader>t9", ":tabn 9<CR>", ns)    -- go to ninth tab
keymap.set("n", "<leader>tt", ":tabedit %<CR>", ns) -- opens current buffer in another tab (kinda temp fullscreen hack)
-- motion
keymap.set("n", "<M-h>", "<C-\\><C-n><C-w>h", ns)
keymap.set("n", "<M-j>", "<C-\\><C-n><C-w>j", ns)
keymap.set("n", "<M-k>", "<C-\\><C-n><C-w>k", ns)
keymap.set("n", "<M-l>", "<C-\\><C-n><C-w>l", ns)
keymap.set('n', '<C-w>h', '<Nop>', ns)
keymap.set('n', '<C-w>j', '<Nop>', ns)
keymap.set('n', '<C-w>k', '<Nop>', ns)
keymap.set('n', '<C-w>l', '<Nop>', ns)
keymap.set("n", "<leader>sv", "<C-w>v<C-w>l", ns)               -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s<C-w>j", ns)               -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", ns)                     -- spit windows in equal width
keymap.set("n", "<leader>sx", ":close<CR>", ns)                 -- close current split window
keymap.set('n', '<C-W><C-l>', ':vertical resize +15<CR>', ns)   -- increment window size
keymap.set('n', '<C-W><C-h>', ':vertical resize -15<CR>', ns)   -- decrement window size
keymap.set('n', '<C-W><C-j>', ':horizontal resize +10<CR>', ns) -- increment window size
keymap.set('n', '<C-W><C-k>', ':horizontal resize -10<CR>', ns) -- decrement window size
-- diagnostics
keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', ns)
keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', ns)
vim.keymap.set("n", "<leader>d", function() -- open diagnostics in a floating window
  vim.diagnostic.open_float(nil, { focus = true })
end, { desc = "Show diagnostics in a floating window" })

vim.keymap.set('n', '<leader>cd', function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
  if #diagnostics > 0 then
    vim.fn.setreg('+', diagnostics[1].message)
  end
end)
-- small terminal
keymap.set('n', '<space>st', function() vim.cmd('below 10split | term') end, ns)
-- restart lsp
keymap.set('n', '<space>r', function()
  vim.cmd('LspRestart')
  vim.notify('lsp restarted', vim.log.levels.INFO)
end, ns)
-- close buffer
keymap.set('n', '<BS>b', function() -- close buffer and go to next
  local bufnr = vim.fn.bufnr()
  vim.cmd('bnext')
  vim.cmd('bdelete ' .. bufnr)
  vim.notify('buffer ' .. bufnr .. ' closed', vim.log.levels.INFO)
end, ns)
--
-- ! auto commands
--
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.textwidth = 35 -- Set line width to 80 characters
    vim.opt_local.wrap = true    -- Enable soft wrapping
  end,
})

--
-- ! user commands
--
-- GoGenerate command
local GoGenerate = function() -- execute go generate in the current directory
  local cwd = vim.fn.expand("%:p:h")
  vim.notify("Running go generate at " .. cwd, vim.log.levels.INFO)
  -- change to the directory of the current file
  vim.cmd("lcd " .. cwd)
  -- capture the output of the command
  local output = vim.fn.systemlist("go generate")
  for _, line in ipairs(output) do
    vim.notify(line, vim.log.levels.INFO)
  end
end
vim.api.nvim_create_user_command("GoGenerate", GoGenerate, { desc = "Run go generate" })

-- Notes command
local notes_term_buf = -1
local notes_term_win = -1
local notes_dir = vim.fn.expand('$NOTE_PATH/') -- precompute to avoid slow execution

local function Notes(opts)
  local width = 45

  -- If the window exists and is valid, close it
  if notes_term_buf and vim.api.nvim_win_is_valid(notes_term_win) then
    -- Save all modified buffers that are markdown files in the notes directory
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'modified') then
        local buf_name = vim.api.nvim_buf_get_name(buf)
        if buf_name:match('%.md$') and buf_name:find(notes_dir, 1, true) then
          vim.api.nvim_buf_call(buf, function()
            vim.cmd('write')
          end)
        end
      end
    end

    -- Close all buffers in the notes directory
    local files_in_notes_dir = vim.fn.glob(notes_dir .. '*.md')
    for _, file in ipairs(vim.split(files_in_notes_dir, '\n')) do
      if file ~= '' then
        local buf = vim.fn.bufnr(file)
        if buf ~= -1 and vim.api.nvim_buf_is_valid(buf) then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
    end

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

    local notes_file = notes_dir
    if opts.file_name then
      -- If a file name is provided, use it
      notes_file = notes_dir .. opts.file_name
    end
    vim.cmd('e ' .. notes_file) -- Use the precomputed path

    -- Store references to the buffer and window
    notes_term_buf = vim.api.nvim_get_current_buf()
    notes_term_win = vim.api.nvim_get_current_win()

    -- Set buffer options
    vim.api.nvim_buf_set_option(notes_term_buf, 'bufhidden', 'hide')
    vim.api.nvim_buf_set_option(notes_term_buf, 'buflisted', false)
  end
end

vim.api.nvim_create_user_command("Notes", Notes, { desc = "Open notes" })
vim.api.nvim_create_user_command("NotesTempFile", function()
  local file_name = os.date('%Y-%m-%d_%H-%M-%S')   -- use current date and time as file name
  local temp_file = '/tmp/' .. file_name .. '.md'
  Notes({ file_name = temp_file })                 -- open the temp file in notes
end, { desc = "create temp file and opens" })
vim.keymap.set('n', '<leader>n', ':Notes<CR>', ns)

-- CopyFilePath command
vim.api.nvim_create_user_command("CopyFilePath", function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  vim.notify('copied ' .. path, vim.log.levels.INFO)
end, { desc = "Copy file path" })


-- Mock command
vim.api.nvim_create_user_command('Mock', function() --open random files so i can test some plugin
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

-- Goose command
local goose_term_buf = nil
local goose_term_win = nil
function ToggleGooseTerminal()
  local width = 65

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

vim.api.nvim_create_user_command('ToggleGooseTerminal', ToggleGooseTerminal, {})
vim.api.nvim_set_keymap('n', '<leader>aI', ':ToggleGooseTerminal<CR>', { noremap = true, silent = true })

-- Codex command
local codex_term_buf = nil
local codex_term_win = nil

function ToggleCodexTerminal()
  local width = 65

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
    vim.cmd('terminal codex --approval-mode full-auto')
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

vim.api.nvim_create_user_command('ToggleCodexTerminal', ToggleCodexTerminal, {})
vim.api.nvim_set_keymap('n', '<leader>ai', ':ToggleCodexTerminal<CR>', { noremap = true, silent = true })

-- claude command
local claude_term_buf = nil
local claude_term_win = nil

function ToggleClaudeTerminal()
  local width = 65

  -- If the window exists and is valid, close it
  if claude_term_win and vim.api.nvim_win_is_valid(claude_term_win) then
    vim.api.nvim_win_close(claude_term_win, true)
    claude_term_win = nil
    return
  end

  -- If we have a buffer but no window, create a new window
  if claude_term_buf and vim.api.nvim_buf_is_valid(claude_term_buf) then
    -- Create a new window on the right
    vim.cmd('botright vertical split')
    -- Resize to specified width
    vim.cmd('vertical resize ' .. width)
    -- Set the window to use our existing buffer
    claude_term_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(claude_term_win, claude_term_buf)
    -- Enter insert mode
    vim.cmd('startinsert')
  else
    -- Create new window and buffer
    vim.cmd('botright vertical new')
    -- Resize to specified width
    vim.cmd('vertical resize ' .. width)
    -- Start claude in a terminal
    -- claude session -n session-name
    -- claude session -r
    -- claude session -r --name session-name
    vim.cmd('terminal claude')
    -- Store references to the buffer and window
    claude_term_buf = vim.api.nvim_get_current_buf()
    claude_term_win = vim.api.nvim_get_current_win()
    -- Enter insert mode
    vim.cmd('startinsert')

    -- Set buffer options for the terminal
    vim.api.nvim_buf_set_option(claude_term_buf, 'bufhidden', 'hide')
    vim.api.nvim_buf_set_option(claude_term_buf, 'buflisted', false)
  end
end

vim.api.nvim_create_user_command('ToggleClaudeTerminal', ToggleClaudeTerminal, {})
-- vim.api.nvim_set_keymap('n', '<leader>ai', ':ToggleClaudeTerminal<CR>', { noremap = true, silent = true })


--
-- ! plugins
--
local harpoon = require('harpoon')
local harpoon_ui = require('harpoon.ui')

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>aa", function()
  harpoon:list():add()
  vim.notify("Added current file to harpoon", vim.log.levels.INFO)
end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
