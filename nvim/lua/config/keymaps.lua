local harpoon = require("harpoon")
local ns = { noremap = true, silent = true }

vim.keymap.set("n", "<space>ss", function()
  -- vim.lsp.buf.format()
  require("conform").format()
  vim.cmd("w")
  vim.notify("File saved successfully", vim.log.levels.INFO)
end, {})

vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", ns)
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", ns)
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", ns)
vim.keymap.set("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", ns)

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>", ns)
vim.keymap.set("n", "<space>x", ":.lua<CR>", ns)
vim.keymap.set("v", "<space>x", ":lua<CR>", ns)
vim.keymap.set("n", "<C-w>_", "<cmd>vs eadirection=hor<CR>", ns)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", ns) -- exit terminal with esc
vim.keymap.set("n", "<Leader><CR>", ":noh<CR>", ns) -- Clear highlight
vim.keymap.set("n", "<leader>+", "<C-a>", ns) -- increment number
vim.keymap.set("n", "<leader>-", "<C-x>", ns) -- decrement number
vim.keymap.set("n", "<space><space><space>", "o<esc>30i<CR><esc>", ns)
-- vim.keymap('n', '<Leader>bd', ':bd<CR>', ns)                                    -- Close buffer
-- vim.keymap("n", "<A-TAB>", "<C-^>", ns)
-- vim.keymap('n', 'Q', '<Nop>', ns)                                               -- Disable ex mode. I dunno what is it
vim.keymap.set("", "]b", ":bnext<CR>", ns)
vim.keymap.set("", "[b", ":bprevious<CR>", ns)
vim.keymap.set("", "]c", ":cnext<CR>", ns)
vim.keymap.set("", "[c", ":cprevious<CR>", ns)
-- vim.keymap('n', '<Leader>dq', '<C-W>k <C-W>o', ns)    -- Close compare buffs
-- vim.keymap('n', '<Leader>da', ':diffget //2<CR>', ns) -- Get content from left side
-- vim.keymap('n', '<Leader>dl', ':diffget //3<CR>', ns) -- Get content from right side
-- vim.keymap('n', '<Leader>gl', ':0GcLog<CR>', ns)
-- vim.keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', ns)
-- vim.keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', ns)
-- tabs (dont tell anyone i'm using it)
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", ns) -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", ns) -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", ns) -- go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", ns) -- go to previous tab
vim.keymap.set("n", "<leader>t1", ":tabn 1<CR>", ns) -- go to first tab
vim.keymap.set("n", "<leader>t2", ":tabn 2<CR>", ns) -- go to second tab
vim.keymap.set("n", "<leader>t3", ":tabn 3<CR>", ns) -- go to third tab
vim.keymap.set("n", "<leader>t4", ":tabn 4<CR>", ns) -- go to fourth tab
vim.keymap.set("n", "<leader>t5", ":tabn 5<CR>", ns) -- go to fifth tab
vim.keymap.set("n", "<leader>t6", ":tabn 6<CR>", ns) -- go to sixth tab
vim.keymap.set("n", "<leader>t7", ":tabn 7<CR>", ns) -- go to seventh tab
vim.keymap.set("n", "<leader>t8", ":tabn 8<CR>", ns) -- go to eighth tab
vim.keymap.set("n", "<leader>t9", ":tabn 9<CR>", ns) -- go to ninth tab
vim.keymap.set("n", "<leader>tt", ":tabedit %<CR>", ns) -- opens current buffer in another tab (kinda temp fullscreen hack)
-- motion
vim.keymap.set("n", "<M-h>", "<C-\\><C-n><C-w>h", ns)
vim.keymap.set("n", "<M-j>", "<C-\\><C-n><C-w>j", ns)
vim.keymap.set("n", "<M-k>", "<C-\\><C-n><C-w>k", ns)
vim.keymap.set("n", "<M-l>", "<C-\\><C-n><C-w>l", ns)
vim.keymap.set("n", "<C-w>h", "<Nop>", ns)
vim.keymap.set("n", "<C-w>j", "<Nop>", ns)
vim.keymap.set("n", "<C-w>k", "<Nop>", ns)
vim.keymap.set("n", "<C-w>l", "<Nop>", ns)
vim.keymap.set("n", "<leader>sv", "<C-w>v<C-w>l", ns) -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s<C-w>j", ns) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", ns) -- spit windows in equal width
vim.keymap.set("n", "<leader>sx", ":close<CR>", ns) -- close current split window
vim.keymap.set("n", "<C-W><C-l>", ":vertical resize +15<CR>", ns) -- increment window size
vim.keymap.set("n", "<C-W><C-h>", ":vertical resize -15<CR>", ns) -- decrement window size
vim.keymap.set("n", "<C-W><C-j>", ":horizontal resize +10<CR>", ns) -- increment window size
vim.keymap.set("n", "<C-W><C-k>", ":horizontal resize -10<CR>", ns) -- decrement window size

-- diagnostics
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", ns)
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", ns)
vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.open_float(nil, { focus = true })
end, { desc = "Show diagnostics in a floating window" })
vim.keymap.set("n", "<leader>cd", function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
  if #diagnostics > 0 then
    vim.fn.setreg("+", diagnostics[1].message)
  end
end)

-- small terminal
vim.keymap.set("n", "<leader>st", function()
  vim.cmd("below 10split | term")
end, ns)

-- close buffer
vim.keymap.set("n", "<BS>b", function() -- close buffer and go to next
  local bufnr = vim.fn.bufnr()
  vim.cmd("bnext")
  vim.cmd("bdelete " .. bufnr)
  vim.notify("buffer " .. bufnr .. " closed", vim.log.levels.INFO)
end, ns)

-- harpoon
harpoon:setup() -- required
vim.keymap.set("n", "<leader>aa", function()
  harpoon:list():add()
  vim.notify("Added current file to harpoon", vim.log.levels.INFO)
end)
vim.keymap.set("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set("n", "<leader>1", function()
  harpoon:list():select(1)
end)
vim.keymap.set("n", "<leader>2", function()
  harpoon:list():select(2)
end)
vim.keymap.set("n", "<leader>3", function()
  harpoon:list():select(3)
end)
vim.keymap.set("n", "<leader>4", function()
  harpoon:list():select(4)
end)

-- oil.nvim
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
