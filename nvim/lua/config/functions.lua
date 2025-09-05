-- DeleteHiddenBuffersForced command
local function DeleteHiddenBuffersForced()
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
      if not is_visible and not vim.api.nvim_buf_get_option(buf, "modified") then
        vim.api.nvim_buf_delete(buf, { force = true })
        deleted = deleted + 1
      end
    end
  end

  vim.notify(deleted .. " hidden buffer(s) deleted", vim.log.levels.INFO)
end

-- Mock command
local function Mock()
  --open random files so i can test some plugin
  vim.cmd("e ~/.config/nvim/init.lua")
  vim.cmd.split()
  vim.cmd("e ~/.config/nvim/lua/kcalixto/lsp.lua")
  vim.cmd.split()
  vim.cmd("e ~/.config/nvim/lua/kcalixto/completion.lua")
  vim.cmd.vsplit()
  vim.cmd("e ~/.config/nvim/lua/kcalixto/lazy.lua")
  vim.cmd("below 10split | term")
end

-- CopyFilePath command
local function CopyFilePath()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("copied " .. path, vim.log.levels.INFO)
end

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

-- Notes command
-- local notes_term_buf = -1
-- local notes_term_win = -1
-- local notes_dir = vim.fn.expand('$NOTE_PATH/') -- precompute to avoid slow execution
--
-- local function Notes(opts)
--   local width = 45
--
--   -- If the window exists and is valid, close it
--   if notes_term_buf and vim.api.nvim_win_is_valid(notes_term_win) then
--     -- Save all modified buffers that are markdown files in the notes directory
--     for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--       if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'modified') then
--         local buf_name = vim.api.nvim_buf_get_name(buf)
--         if buf_name:match('%.md$') and buf_name:find(notes_dir, 1, true) then
--           vim.api.nvim_buf_call(buf, function()
--             vim.cmd('write')
--           end)
--         end
--       end
--     end
--
--     -- Close all buffers in the notes directory
--     local files_in_notes_dir = vim.fn.glob(notes_dir .. '*.md')
--     for _, file in ipairs(vim.split(files_in_notes_dir, '\n')) do
--       if file ~= '' then
--         local buf = vim.fn.bufnr(file)
--         if buf ~= -1 and vim.api.nvim_buf_is_valid(buf) then
--           vim.api.nvim_buf_delete(buf, { force = true })
--         end
--       end
--     end
--
--     vim.api.nvim_win_close(notes_term_win, true)
--     notes_term_win = -1
--     return
--   end
--
--   if notes_term_buf and vim.api.nvim_buf_is_valid(notes_term_buf) then
--     -- Create a new window on the right
--     vim.cmd('botright vertical split')
--     -- Resize to specified width
--     vim.cmd('vertical resize ' .. width)
--     -- Set the window to use our existing buffer
--     notes_term_win = vim.api.nvim_get_current_win()
--     vim.api.nvim_win_set_buf(notes_term_win, notes_term_buf)
--   else
--     -- Create new window and buffer
--     vim.cmd('botright vertical new')
--     -- Resize to specified width
--     vim.cmd('vertical resize ' .. width)
--
--     local notes_file = notes_dir
--     if opts.file_name then
--       -- If a file name is provided, use it
--       notes_file = notes_dir .. opts.file_name
--     end
--     vim.cmd('e ' .. notes_file) -- Use the precomputed path
--
--     -- Store references to the buffer and window
--     notes_term_buf = vim.api.nvim_get_current_buf()
--     notes_term_win = vim.api.nvim_get_current_win()
--
--     -- Set buffer options
--     vim.api.nvim_buf_set_option(notes_term_buf, 'bufhidden', 'hide')
--     vim.api.nvim_buf_set_option(notes_term_buf, 'buflisted', false)
--   end
-- end
--
-- local function NotesTempFile()
--   local file_name = os.date('%Y-%m-%d_%H-%M-%S')   -- use current date and time as file name
--   local temp_file = '/tmp/' .. file_name .. '.md'
--   Notes({ file_name = temp_file })                 -- open the temp file in notes
-- end

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
    vim.cmd("botright vertical split")
    -- Resize to specified width
    vim.cmd("vertical resize " .. width)
    -- Set the window to use our existing buffer
    goose_term_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(goose_term_win, goose_term_buf)
    -- Enter insert mode
    vim.cmd("startinsert")
  else
    -- Create new window and buffer
    vim.cmd("botright vertical new")
    -- Resize to specified width
    vim.cmd("vertical resize " .. width)
    -- Start goose in a terminal
    -- goose session -n session-name
    -- goose session -r
    -- goose session -r --name session-name
    vim.cmd("terminal goose")
    -- Store references to the buffer and window
    goose_term_buf = vim.api.nvim_get_current_buf()
    goose_term_win = vim.api.nvim_get_current_win()
    -- Enter insert mode
    vim.cmd("startinsert")

    -- Set buffer options for the terminal
    vim.api.nvim_buf_set_option(goose_term_buf, "bufhidden", "hide")
    vim.api.nvim_buf_set_option(goose_term_buf, "buflisted", false)
  end
end

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
    vim.cmd("botright vertical split")
    -- Resize to specified width
    vim.cmd("vertical resize " .. width)
    -- Set the window to use our existing buffer
    codex_term_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(codex_term_win, codex_term_buf)
    -- Enter insert mode
    vim.cmd("startinsert")
  else
    -- Create new window and buffer
    vim.cmd("botright vertical new")
    -- Resize to specified width
    vim.cmd("vertical resize " .. width)
    -- Start codex in a terminal
    -- codex session -n session-name
    -- codex session -r
    -- codex session -r --name session-name
    vim.cmd("terminal codex --approval-mode full-auto")
    -- Store references to the buffer and window
    codex_term_buf = vim.api.nvim_get_current_buf()
    codex_term_win = vim.api.nvim_get_current_win()
    -- Enter insert mode
    vim.cmd("startinsert")

    -- Set buffer options for the terminal
    vim.api.nvim_buf_set_option(codex_term_buf, "bufhidden", "hide")
    vim.api.nvim_buf_set_option(codex_term_buf, "buflisted", false)
  end
end

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
    vim.cmd("botright vertical split")
    -- Resize to specified width
    vim.cmd("vertical resize " .. width)
    -- Set the window to use our existing buffer
    claude_term_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(claude_term_win, claude_term_buf)
    -- Enter insert mode
    vim.cmd("startinsert")
  else
    -- Create new window and buffer
    vim.cmd("botright vertical new")
    -- Resize to specified width
    vim.cmd("vertical resize " .. width)
    -- Start claude in a terminal
    -- claude session -n session-name
    -- claude session -r
    -- claude session -r --name session-name
    vim.cmd("terminal claude")
    -- Store references to the buffer and window
    claude_term_buf = vim.api.nvim_get_current_buf()
    claude_term_win = vim.api.nvim_get_current_win()
    -- Enter insert mode
    vim.cmd("startinsert")

    -- Set buffer options for the terminal
    vim.api.nvim_buf_set_option(claude_term_buf, "bufhidden", "hide")
    vim.api.nvim_buf_set_option(claude_term_buf, "buflisted", false)
  end
end

-- TS Language Server commands
function TSOrganizeImports()
  local clients = vim.lsp.get_active_clients({ name = "ts_ls" })
  if #clients > 0 then
    clients[1].request("workspace/executeCommand", {
      command = "_typescript.organizeImports",
      arguments = { vim.api.nvim_buf_get_name(0) },
    })
  end
end

-- on startup
vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    vim.api.nvim_create_user_command("Mock", Mock, {})
    -- vim.api.nvim_create_user_command("Notes", Notes, {})
    -- vim.api.nvim_create_user_command("NotesTempFile", NotesTempFile, {})

    vim.keymap.set("n", "<leader>n", ":Notes<CR>")
  end,
})

-- on buf enter
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.api.nvim_create_user_command("CopyFilePath", CopyFilePath, { desc = "Copy file path" })
    vim.api.nvim_create_user_command("ToggleClaudeTerminal", ToggleClaudeTerminal, {})
    vim.api.nvim_create_user_command("ToggleCodexTerminal", ToggleCodexTerminal, {})
    vim.api.nvim_create_user_command("ToggleGooseTerminal", ToggleGooseTerminal, {})
  end,
})

-- on buf hide
vim.api.nvim_create_autocmd("BufHidden", {
  callback = function()
    vim.api.nvim_create_user_command("DeleteHiddenBuffersForced", DeleteHiddenBuffersForced, {})
  end,
})

-- by file type
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.textwidth = 35 -- Set line width to 80 characters
    vim.opt_local.wrap = true -- Enable soft wrapping
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.api.nvim_create_user_command("GoGenerate", GoGenerate, {})
    vim.api.nvim_buf_set_keymap(0, "n", "<C-i>", ":GoImport<CR>", {})
    vim.api.nvim_buf_set_keymap(0, "n", "<C-t>", ":GoTestPkg<CR>", {})
    vim.api.nvim_buf_set_keymap(0, "n", "<C-c>", ":GoCoverage -p<CR>", {})
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  callback = function()
    vim.api.nvim_create_user_command("TSOrganizeImports", TSOrganizeImports, {})
    vim.api.nvim_buf_set_keymap(0, "n", "<C-i>", ":TSOrganizeImports<CR>", {})
  end,
})
