local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
vim.fn.setreg("l", '"tdifmt.Sprintf()' .. esc .. '"tP')
