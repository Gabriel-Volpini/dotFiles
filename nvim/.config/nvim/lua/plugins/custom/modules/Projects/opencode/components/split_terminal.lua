---@alias Agents "Lua" | "typescript"

---@class OpenCodeSplit
---@field visible boolean
---@field bufnr number
---@field setup fun(opts: { ag:Agents, toggleKeyMap:string }): nil
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

local function toggle()
  if not M.visible then
    splitRef:show()
  else
    splitRef:hide()
  end
  M.visible = not M.visible
end

local function createBasicKeymaps(toggleKeyMap)
  splitRef:map("t", "<esc><esc>", function()
    vim.cmd("stopinsert")
  end)

  splitRef:map("n", "q", toggle)
  splitRef:map("n", toggleKeyMap, toggle)
  splitRef:map("t", toggleKeyMap, toggle)
  vim.keymap.set({ "n", "i", "v" }, toggleKeyMap, toggle)

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

---@param ag Agents
local function createOpenCodeTerminalInstance(ag)
  vim.api.nvim_buf_call(splitRef.bufnr, function()
    vim.fn.jobstart({ "zsh", "-c", "opencode --agent " .. ag }, {
      term = true,
      cwd = vim.fn.getcwd(),
      on_exit = function()
        splitRef:unmount()

        M.setup(M.opts)
      end,
    })
  end)
end

function M.setup(opts)
  M.opts = opts
  createSplit()
  createBasicKeymaps(opts.toggleKeyMap)
  createAutoCommands()
  createOpenCodeTerminalInstance(opts.ag)
end

M.setup({
  ag = "Lua",
  toggleKeyMap = "<C-t>",
})
toggle()

return M
