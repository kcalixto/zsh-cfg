local function term(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.fn.setreg("r", "gnPw")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    -- log macro
    vim.fn.setreg("l", '"tdifmt.Sprintf()' .. term("<Esc>") .. '"tP')
    vim.fn.setreg(
      "n",
      "0" -- move to start of line
        .. "f(" -- find first parenthesis
        .. "a"
        .. term("<CR><Esc>") -- append new line after the parenthesis
        .. "f)" -- find the closing parenthesis
        .. "i,"
        .. term("<CR><Esc>") -- insert a comma before the closing parenthesis
        .. "k" -- move up one line to where the text is
        .. ":s/,/,"
        .. term("\\r")
        .. "/g"
        .. term("<CR>") -- replace all commas with a new line
        .. "dd"
        .. term("<Esc>") -- delete the line created by replace
        .. term("<leader><CR>") -- clear highlights created by the replace command
    )
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
    local logabove = '"tyOconsole.log({'
      .. term("<CR>")
      .. term("<Esc>")
      .. '"tPA,'
      .. term("<CR>")
      .. "})"
      .. term("<Esc>")

    -- local logbelow = '"tyoconsole.log({'
    --   .. term("<CR>")
    --   .. term("<Esc>")
    --   .. '"tPA,'
    --   .. term("<CR>")
    --   .. "})"
    --   .. term("<Esc>")

    vim.fn.setreg("l", logabove)
    -- vim.fn.setreg("l", logbelow)
  end,
})
