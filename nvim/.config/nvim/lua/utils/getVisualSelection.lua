-- Save this somewhere (e.g., in your utils.lua)
local function get_visual_selection()
  -- If we're not currently in visual mode, reselect last selection (handles vif, viw, etc.)
  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" and mode ~= "\022" then
    vim.cmd("normal! gv")
  end

  -- Get the visual marks (these always exist after a selection)
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  local line_start = math.min(start_pos[2], end_pos[2])
  local col_start = math.min(start_pos[3], end_pos[3])
  local line_end = math.max(start_pos[2], end_pos[2])
  local col_end = math.max(start_pos[3], end_pos[3])

  local lines = vim.api.nvim_buf_get_lines(0, line_start - 1, line_end, false)
  if #lines == 0 then
    return ""
  end

  -- Detect selection type (visual, line, block)
  local vmode = vim.fn.mode(true)
  local is_linewise = (start_pos[3] == 1 and end_pos[3] == 2147483647)
  local is_blockwise = (vmode == "\022")

  -- Handle linewise selection
  if is_linewise then
    return table.concat(lines, "\n")
  end

  -- Handle blockwise (<C-v>) selection
  if is_blockwise then
    local block_lines = {}
    for _, line in ipairs(lines) do
      local s = math.min(col_start, #line)
      local e = math.min(col_end, #line)
      if s <= e then
        table.insert(block_lines, line:sub(s, e))
      else
        table.insert(block_lines, "")
      end
    end
    return table.concat(block_lines, "\n")
  end

  -- Handle characterwise selection
  if line_start == line_end then
    return lines[1]:sub(col_start, col_end)
  else
    lines[1] = lines[1]:sub(col_start)
    lines[#lines] = lines[#lines]:sub(1, col_end)
    return table.concat(lines, "\n")
  end
end

return get_visual_selection
