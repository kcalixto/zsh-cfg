local notes_file = vim.fn.stdpath("data") .. "/notes.txt"

local function get_timestamp()
  return os.date("%d/%m/%Y %H:%M")
end

local function add_note(note)
  local f = io.open(notes_file, "a")
  if f then
    f:write(string.format("{ %s } [ ] %s\n", get_timestamp(), note))
    f:close()
    print("Note added!")
  else
    print("Failed to open notes file.")
  end
end

local read_notes_bufrn = nil
local read_notes_winid = nil
local function read_notes()
  local buf

  if read_notes_winid and vim.api.nvim_win_is_valid(read_notes_winid) then
    vim.api.nvim_set_current_win(read_notes_winid)
    return
  end

  if read_notes_bufrn and vim.api.nvim_buf_is_valid(read_notes_bufrn) then
    buf = read_notes_bufrn
  else
    buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(buf, "Notes")
    vim.api.nvim_buf_set_option(buf, "buftype", "")
    vim.api.nvim_buf_set_option(buf, "modifiable", true)
    read_notes_bufrn = buf
  end

  local width = math.floor(vim.o.columns * 0.7)
  local height = math.floor(vim.o.lines * 0.7)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  read_notes_winid = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  vim.api.nvim_set_current_win(read_notes_winid)
  vim.api.nvim_set_current_buf(buf)
  vim.cmd("edit " .. notes_file)
end

return {
  add_note = add_note,
  read_notes = read_notes,
}
