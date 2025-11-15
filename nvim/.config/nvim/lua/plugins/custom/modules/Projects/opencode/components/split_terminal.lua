---@alias OpencodeAgents "Lua" | "typescript"
---@alias OpencodeOPTS { ag:OpencodeAgents, toggleKeyMap:string, visualSelectionKeyMap: string }

---@class OpenCodeSplit
---@field visible boolean
---@field bufnr number
---@field setup fun(opts: OpencodeOPTS): nil
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
      filetype = "markdown",
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

  -- TODO: unecessary, justadd the terminal state into the project save
  splitRef:on(event.VimLeave, function()
    splitRef:unmount()
  end)
end

local job_id
---@param ag OpencodeAgents
local function createOpenCodeTerminalInstance(ag, opts)
  vim.api.nvim_buf_call(splitRef.bufnr, function()
    job_id = vim.fn.jobstart({ "zsh", "-c", "opencode --agent " .. ag }, {
      term = true,
      cwd = vim.fn.getcwd(),
      on_exit = function()
        splitRef:unmount()

        M.setup(opts)
      end,
    })
  end)
end

local function createVisualInstanceHandler(keymap)
  vim.keymap.set("v", keymap, function()
    if not job_id then
      return
    end

    vim.cmd('noautocmd normal! "vy')
    local text = vim.fn.getreg("v")

    vim.fn.chansend(job_id, text)

    splitRef:show()
    vim.cmd("startinsert")
  end)
end

function M.setup(opts)
  createSplit()
  createBasicKeymaps(opts.toggleKeyMap)
  createAutoCommands()
  createOpenCodeTerminalInstance(opts.ag, opts)
  createVisualInstanceHandler(opts.visualSelectionKeyMap)
end

return M
