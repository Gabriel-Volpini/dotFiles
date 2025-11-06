return function(data)
  local text = data and vim.inspect(data) or "nil"

  -- Create a scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(buf, "filetype", "lua") -- 🔥 Lua syntax highlighting

  -- Insert text
  local lines = vim.split(text, "\n")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Compute floating window size and position
  local width = math.floor(vim.o.columns * 0.6)
  local height = math.floor(vim.o.lines * 0.6)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Open floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = "🐛 Debug",
  })

  -- Force Normal mode so it doesn’t start in Insert
  vim.cmd("stopinsert")

  -- Optional: close with 'q'
  vim.keymap.set("n", "q", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, nowait = true, silent = true })
end
