---@alias Agents "Lua" | "typescript"

---@class OpenCodeSplit
---@field visible boolean
---@field bufnr number
---@field setup fun(opts: {ag:Agents}): nil
---@field toggle fun(): nil
local M = {}

local splitRef

local function createSplit()
  local Split = require("nui.split")

  splitRef = Split({
    relative = "editor",
    position = "right",
    size = "40%",
    win_options = {
      number = false,
      relativenumber = false,
      signcolumn = "no",
      list = false,
    },
    buf_options = {
      filetype = "zsh",
    },
  })

  splitRef:mount()
  splitRef:hide()

  M.bufnr = splitRef.bufnr
  M.visible = false
end

---@param ag Agents
local function createOpenCodeTerminalInstance(ag)
  vim.api.nvim_buf_call(splitRef.bufnr, function()
    vim.fn.jobstart({ "zsh", "-c", "opencode --agent " .. ag }, {
      term = true,
      cwd = vim.fn.getcwd(),
      on_exit = function()
        splitRef:unmount()
      end,
    })
  end)
end

local function createBasicKeymaps()
  splitRef:map("t", "<esc><esc>", function()
    vim.cmd("stopinsert")
  end)

  splitRef:map("n", "q", function()
    splitRef:hide()
    M.visible = false
  end)

  splitRef:map("t", "<C-h>", "<C-\\><C-n><C-w>h")
  splitRef:map("t", "<C-j>", "<C-\\><C-n><C-w>j")
  splitRef:map("t", "<C-k>", "<C-\\><C-n><C-w>k")
  splitRef:map("t", "<C-l>", "<C-\\><C-n><C-w>l")
end

local function createAutoCommands()
  local event = require("nui.utils.autocmd").event
  splitRef:on(event.BufEnter, function()
    vim.cmd("startinsert")
  end)
end

function M.toggle()
  Utils.debug(M.visible)
  if M.visible then
    -- splitRef:hide()
  else
    -- splitRef:show()
  end

  M.visible = not M.visible
end

function M.setup(opts)
  createSplit()
  createOpenCodeTerminalInstance(opts.ag)
  createBasicKeymaps()
  createAutoCommands()
end

return M
