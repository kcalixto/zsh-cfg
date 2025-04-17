vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- haha no way it works LOL
local winid = -1
vim.keymap.set('n', '<space>e', function()
  if vim.g.kcalixto_oil_open then
    vim.g.kcalixto_oil_open = false
    vim.api.nvim_win_close(winid, false)
  else
    vim.g.kcalixto_oil_open = true -- toggle var hehe
    local currentbuffpath = vim.api.nvim_buf_get_name(0)
    local buffpathwithoutcwd = string.sub(currentbuffpath, string.len(vim.fn.getcwd()) + 2)
    local pathtable = split(buffpathwithoutcwd, '/')
    table.remove(pathtable, nil) -- remove last element

    local buffpath = ''
    for _, v in ipairs(pathtable) do
      buffpath = buffpath .. v .. '/'
    end

    vim.cmd.vnew()              -- new window
    vim.cmd('Oil ' .. buffpath) -- opens oil of course
    vim.cmd.wincmd('H')         -- mv window to far left
    vim.api.nvim_win_set_width(0, 35)
    winid = vim.fn.win_getid()  -- saves id for close later
  end
end)

local winidall = -1
vim.keymap.set('n', '<space>E', function()
  if vim.g.kcalixto_oil_all_open then
    vim.g.kcalixto_oil_all_open = false
    vim.api.nvim_win_close(winidall, false)
  else
    vim.g.kcalixto_oil_all_open = true -- toggle var hehe
    vim.cmd.vnew()                     -- new window
    vim.cmd('Oil')                     -- opens oil of course
    vim.cmd.wincmd('H')                -- mv window to far left
    vim.api.nvim_win_set_width(0, 35)
    winidall = vim.fn.win_getid()      -- saves id for close later
  end
end)

function split(str, pat)
  local t = {}
  local fpat = "(.-)" .. pat
  local last_end = 1
  local s, e, cap = str:find(fpat, 1)
  while s do
    if s ~= 1 or cap ~= "" then
      table.insert(t, cap)
    end
    last_end = e + 1
    s, e, cap = str:find(fpat, last_end)
  end
  if last_end <= #str then
    cap = str:sub(last_end)
    table.insert(t, cap)
  end
  return t
end

return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      prompt_save_on_select_new_entry = true,
      delete_to_trash = true,
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
      },
      columns = {
        "icon",
        -- "permissions",
        "size",
        -- "mtime",
      },
      -- keymaps = { -- not working bcs oil is kinda file buffer
      --   ["<space>"] = "actions.select",
      -- },
    },
    -- Optional dependencies
    -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
  },
}
