return function()
  local groups = {
    "Normal",
    "Comment",
    "String",
    "Number",
    "Identifier",
    "Function",
    "Keyword",
    "Type",
    "Special",
    "Error",
    "Todo",
    "StatusLine",
    "StatusLineNC",
    "VertSplit",
    "Visual",
    "Search",
    "LineNr",
  }

  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(true, true)
  local lines = {}
  local highlights = {}

  -- Add header
  table.insert(lines, "Highlight Group Colors")
  table.insert(lines, "=====================")
  table.insert(lines, "")

  -- Function to convert RGB to hex
  local function rgb_to_hex(color)
    if not color then
      return "NONE"
    end
    return string.format("#%06x", color)
  end

  local line_nr = 3 -- Start after header lines
  -- Get colors for each group
  for _, group in ipairs(groups) do
    local ok, hl = pcall(vim.api.nvim_get_hl_by_name, group, true)
    if ok and hl then
      local fg = rgb_to_hex(hl.foreground)
      local bg = rgb_to_hex(hl.background)
      local line = string.format("%-15s: fg=%-10s bg=%s", group, fg, bg)
      table.insert(lines, line)

      -- Store highlight positions for hex colors
      if hl.foreground then
        table.insert(highlights, {
          line = line_nr,
          col_start = 20, -- position of fg hex
          col_end = 27,
          fg = hl.foreground,
        })
      end

      if hl.background then
        table.insert(highlights, {
          line = line_nr,
          col_start = 32, -- position of bg hex
          col_end = 39,
          bg = hl.background,
        })
      end

      line_nr = line_nr + 1
    else
      local line = string.format("%-15s: NOT FOUND", group)
      table.insert(lines, line)
      line_nr = line_nr + 1
    end
  end

  -- Set buffer content
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Apply highlights for hex colors
  for _, hl_info in ipairs(highlights) do
    local ns = vim.api.nvim_create_namespace("color_preview")
    vim.api.nvim_buf_add_highlight(buf, ns, "", hl_info.line, hl_info.col_start, hl_info.col_end)

    -- Create custom highlight for the hex color
    local hl_name = string.format("ColorPreview_%d_%d", hl_info.line, hl_info.col_start)
    local hl_opts = {}
    if hl_info.fg then
      hl_opts.fg = hl_info.fg
    end
    if hl_info.bg then
      hl_opts.bg = hl_info.bg
    end

    vim.api.nvim_set_hl(0, hl_name, hl_opts)
    vim.api.nvim_buf_set_extmark(buf, ns, hl_info.line, hl_info.col_start, {
      end_col = hl_info.col_end,
      hl_group = hl_name,
    })
  end

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(buf, "modifiable", false)

  -- Open buffer in current window
  vim.api.nvim_set_current_buf(buf)

  -- Set buffer name
  vim.api.nvim_buf_set_name(buf, "Highlight Colors")
end
