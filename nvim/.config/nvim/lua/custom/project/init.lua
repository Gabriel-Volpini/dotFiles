-- local function debug(data)
--   local text = data and vim.inspect(data) or "nil"
--   vim.notify(text, vim.log.levels.INFO, { title = "🐛 Debug" })
-- end

local M = {}
M.opts = {}
M.currentProject = nil
M.sessionDir = vim.fn.stdpath("data") .. "/project_sessions"

-- ensure session dir exists
vim.fn.mkdir(M.sessionDir, "p")

function M.setup(opts)
  M.opts = opts
end

-----------------------------------------------------------------------
-- 🔧 Helper: get modification time of a session file
-----------------------------------------------------------------------
local function get_session_mtime(name)
  local session = M.sessionDir .. "/" .. name .. ".vim"
  local stat = vim.loop.fs_stat(session)
  return stat and stat.mtime.sec or 0
end

-----------------------------------------------------------------------
-- 📋 Get list of projects, sorted by last saved time
-----------------------------------------------------------------------
function M.getPickerItems()
  local items = M.opts.projects or {}

  -- filter out current project if set
  if M.currentProject then
    items = vim.tbl_filter(function(item)
      return item.name ~= M.currentProject.name
    end, items)
  end

  -- sort by session modification time (descending)
  table.sort(items, function(a, b)
    return get_session_mtime(a.name) > get_session_mtime(b.name)
  end)

  return items
end

-----------------------------------------------------------------------
-- 📦 Select and switch projects
-----------------------------------------------------------------------
function M.select()
  local snacks = require("snacks")
  local items = M.getPickerItems()

  snacks.picker.select(items, {
    prompt = "Select project",
    format_item = function(item)
      return item.name
    end,
  }, function(choice)
    if not choice then
      return
    end
    M.handleSession(choice.name, choice.dir)
  end)
end

-----------------------------------------------------------------------
-- 💾 Save session for current project
-----------------------------------------------------------------------
function M.saveSession(name)
  vim.fn.mkdir(M.sessionDir, "p")
  local session = M.sessionDir .. "/" .. name .. ".vim"
  vim.cmd("mksession! " .. vim.fn.fnameescape(session))
  vim.notify("💾 Saved session for " .. name, vim.log.levels.INFO, { title = "Project" })
end

-----------------------------------------------------------------------
-- 🚪 Close all buffers
-----------------------------------------------------------------------
function M.close_all_buffers()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end

-----------------------------------------------------------------------
-- 🔁 Handle session switching and loading
-----------------------------------------------------------------------
function M.handleSession(name, dir)
  -- save current project before switching
  if M.currentProject then
    M.saveSession(M.currentProject.name)
  end

  ---------------------------------------------------------------------
  -- ✅ Safely close all windows except one
  ---------------------------------------------------------------------
  local wins = vim.api.nvim_list_wins()
  if #wins > 1 then
    for _, win in ipairs(wins) do
      if win ~= vim.api.nvim_get_current_win() then
        pcall(vim.api.nvim_win_close, win, true)
      end
    end
  end

  ---------------------------------------------------------------------
  -- ✅ Close all buffers (but keep one dummy buffer open)
  ---------------------------------------------------------------------
  vim.cmd("enew") -- create an empty scratch buffer
  vim.cmd("only") -- make sure it’s the only window
  M.close_all_buffers()

  ---------------------------------------------------------------------
  -- ✅ Change working directory to the new project
  ---------------------------------------------------------------------
  vim.fn.chdir(vim.fn.expand(dir))

  ---------------------------------------------------------------------
  -- ✅ Load or create the new session
  ---------------------------------------------------------------------
  local session = M.sessionDir .. "/" .. name .. ".vim"
  if vim.fn.filereadable(session) == 1 then
    vim.cmd("silent! source " .. vim.fn.fnameescape(session))
  else
    vim.cmd("mksession! " .. vim.fn.fnameescape(session))
  end

  vim.api.nvim_echo({
    { "Switched to ", "Normal" },
    { name, "String" },
  }, false, {})

  M.currentProject = { name = name, dir = dir }
end

-----------------------------------------------------------------------
-- 🧭 User commands
-----------------------------------------------------------------------
vim.api.nvim_create_user_command("ProjectSelect", function()
  M.select()
end, { desc = "Select a project" })

vim.api.nvim_create_user_command("ProjectSave", function()
  if not M.currentProject then
    vim.notify("No project currently active!", vim.log.levels.WARN, { title = "Project" })
    return
  end
  M.saveSession(M.currentProject.name)
end, { desc = "Save a project" })

-----------------------------------------------------------------------
-- 📝 TODO
-- - Save file tree state
-- - Change tree directory if open
-- - Buffer navigation improvements
-----------------------------------------------------------------------

return M
