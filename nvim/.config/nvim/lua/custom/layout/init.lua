---@param msg any
function debug(msg)
  if type(msg) ~= "string" then
    msg = vim.inspect(msg)
  end
  vim.notify(msg, vim.log.levels.DEBUG)
end

local M = {}

---@param position 'left'|'right'|'top'|'bottom'|nil # default 'right'
---@param size integer|nil # width for vertical, height for horizontal
---@return integer bufnr
function M.open_buffer(position, size)
  local pos = position or "right"

  if pos == "left" then
    vim.cmd("leftabove vsplit")
  elseif pos == "right" then
    vim.cmd("rightbelow vsplit")
  elseif pos == "top" then
    vim.cmd("leftabove split")
  elseif pos == "bottom" then
    vim.cmd("rightbelow split")
  else
    vim.cmd("rightbelow vsplit")
  end

  if type(size) == "number" and size > 0 then
    if pos == "left" or pos == "right" then
      vim.cmd("vertical resize " .. size)
      vim.cmd("setlocal winfixwidth")
    else
      vim.cmd("resize " .. size)
      vim.cmd("setlocal winfixheight")
    end
  end

  vim.cmd("enew")
  local bufnr = vim.api.nvim_get_current_buf()
  return bufnr
end

function M.setup() end

M.open_buffer("left", 30)

-- return M
