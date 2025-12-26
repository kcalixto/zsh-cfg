-- DeleteHiddenBuffersForced command
local function DeleteHiddenBuffersForced()
  -- delete all buffers that does not have a window and were not modified

  local deleted = 0
  local buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(buffers) do
    -- Check if buffer exists and is loaded but not visible in any window
    -- if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
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
    -- end
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

--
local function add_eslint_disable()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local diagnostics = vim.diagnostic.get(0, { lnum = line - 1 })

  if #diagnostics == 0 then
    print("No diagnostics on current line")
    return
  end

  -- Filter for eslint diagnostics
  local eslint_diags = vim.tbl_filter(function(d)
    return d.source == "eslint"
  end, diagnostics)

  if #eslint_diags == 0 then
    print("No eslint diagnostics on current line")
    return
  end

  -- Extract rule name from message (format: "message [rule-name]")
  local rule = eslint_diags[1].code or eslint_diags[1].message:match("%[(.-)%]$")

  if not rule then
    print("Could not extract eslint rule")
    return
  end

  -- Get current indentation
  local current_line_text = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1]
  local indent = current_line_text:match("^%s*")

  -- Insert disable comment
  local comment = indent .. "// eslint-disable-next-line " .. rule
  vim.api.nvim_buf_set_lines(0, line - 1, line - 1, false, { comment })
end

local function InlayHintsEnable()
  if vim.lsp.inlay_hint then
    vim.lsp.inlay_hint(0, true)
  end
end

local function InlayHintsDisable()
  if vim.lsp.inlay_hint then
    vim.lsp.inlay_hint(0, false)
  end
end

-- on startup
vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    vim.api.nvim_create_user_command("Mock", Mock, {})
    vim.api.nvim_create_user_command("InlayHintsEnable", InlayHintsEnable, { desc = "Enable inlay hints" })
    vim.api.nvim_create_user_command("InlayHintsDisable", InlayHintsDisable, { desc = "Disable inlay hints" })
  end,
})

-- on buf enter
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.api.nvim_create_user_command("CopyFilePath", CopyFilePath, { desc = "Copy file path" })
    vim.api.nvim_create_user_command("ToggleClaudeTerminal", ToggleClaudeTerminal, {})
    vim.api.nvim_create_user_command("ToggleCodexTerminal", ToggleCodexTerminal, {})
    vim.api.nvim_create_user_command("ToggleGooseTerminal", ToggleGooseTerminal, {})

    vim.api.nvim_create_user_command(
      "AddEslintDisable",
      add_eslint_disable,
      { desc = "Add eslint disable comment for the rule on the current line" }
    )
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
