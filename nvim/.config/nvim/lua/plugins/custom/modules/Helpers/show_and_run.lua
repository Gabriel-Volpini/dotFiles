---@param shouldOpenBuffer boolean
return function(shouldOpenBuffer)
  local filepath = vim.fn.expand("%:p")
  if not filepath or filepath == "" then
    vim.notify("No file open", vim.log.levels.ERROR)
    return
  end
  local func, err = loadfile(filepath)
  if not func then
    vim.notify("Error loading file: " .. err, vim.log.levels.ERROR)
    return
  end
  local success, result = pcall(func)
  if not success then
    vim.notify("Error executing file: " .. result, vim.log.levels.ERROR)
    return
  end
  local output
  if type(result) == "table" then
    output = vim.inspect(result)
  else
    output = tostring(result)
  end

  if not shouldOpenBuffer then
    return
  end

  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output, "\n"))
  -- Get the current window dimensions
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")
  -- Floating window options
  local win_opts = {
    relative = "editor",
    width = math.floor(width * 0.8),
    height = math.floor(height * 0.8),
    col = math.floor(width * 0.1),
    row = math.floor(height * 0.1),
    style = "minimal",
    border = "rounded",
  }
  -- Open the floating window
  local win = vim.api.nvim_open_win(buf, true, win_opts)
  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  -- Keymap to close the window
  vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
end
