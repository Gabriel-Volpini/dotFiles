local M = {}

M.config = {
  layout = {
    left = { enabled = false },
    right = { enabled = false },
    bottom = { enabled = false },
    top = { enabled = false },
  },
  default_height = 10,
  default_width = 30,
}

M.state = {
  windows = {},
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

-- utility: make a scratch buffer
local function make_scratch(name)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { name .. " window" })
  return buf
end

-- check if layout exists
local function layout_is_open()
  for _, win in pairs(M.state.windows) do
    if vim.api.nvim_win_is_valid(win) then
      return true
    end
  end
  return false
end

function M.close_layout()
  for _, win in pairs(M.state.windows) do
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end
  M.state.windows = {}
end

function M.open_layout()
  local cfg = M.config
  local main_win = vim.api.nvim_get_current_win()
  local wins = {}

  local function open_side(name, cmd)
    local side = cfg.layout[name]
    if not (side and side.enabled) then
      return
    end

    vim.api.nvim_set_current_win(main_win)
    vim.cmd(cmd)

    if side.width and (name == "left" or name == "right") then
      vim.cmd("vertical resize " .. side.width)
    elseif side.height and (name == "top" or name == "bottom") then
      vim.cmd("resize " .. side.height)
    elseif name == "left" or name == "right" then
      vim.cmd("vertical resize " .. cfg.default_width)
    else
      vim.cmd("resize " .. cfg.default_height)
    end

    local win = vim.api.nvim_get_current_win()
    local buf = make_scratch(name:sub(1, 1):upper() .. name:sub(2))

    vim.api.nvim_win_set_buf(win, buf)
    table.insert(wins, win)

    -- Run custom callback
    if type(side.on_open) == "function" then
      pcall(side.on_open, buf, win)
    end
  end

  open_side("right", "vsplit")
  open_side("bottom", "split")
  open_side("left", "topleft vsplit")
  open_side("top", "topleft split")

  vim.api.nvim_set_current_win(main_win)
  M.state.windows = wins
end

function M.toggle_layout()
  if layout_is_open() then
    M.close_layout()
  else
    M.open_layout()
  end
end

vim.api.nvim_create_user_command("MyLayout", function()
  M.toggle_layout()
end, {})

M.setup({
  layout = {
    left = {
      enabled = true,
      width = 50,
      on_open = function(buf, win)
        -- Focus the window temporarily
        vim.api.nvim_set_current_win(win)

        -- Open Snack Explorer here
        vim.cmd("SnackExplorer")

        -- Optionally go back to the main window
        vim.cmd("wincmd l")
      end,
    },
    bottom = {
      enabled = true,
      height = 10,
      on_open = function(buf)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Status window" })
      end,
    },
  },
})

return M
