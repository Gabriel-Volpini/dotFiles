-- local function debug(data)
--   local text = data and vim.inspect(data) or "nil"
--   vim.notify(text, vim.log.levels.INFO, { title = "🐛 Debug" })
-- end

local M = {}
M.opts = { open_tree = true }
M.currentProject = nil
M.sessionDir = vim.fn.stdpath("data") .. "/project_sessions"

-- Ensure session dir exists
vim.fn.mkdir(M.sessionDir, "p")

-- ✅ Make sure sessions actually capture what we need
-- buffers, curdir, tabpages, winsize, folds, help, globals, localoptions, terminal
vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,folds,help,globals,localoptions,terminal"

function M.setup(opts)
  M.opts = opts or {}
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
-- 🧹 Make a truly clean UI state (no E444, no leftovers)
-----------------------------------------------------------------------
local function clean_ui_state()
  -- 1) Create a guaranteed safe tab + empty buffer
  pcall(vim.cmd, "tabnew") -- new tab so we can close others
  pcall(vim.cmd, "enew") -- empty scratch buffer in this tab

  -- 2) Close ALL other tabs (keeps only the current tab)
  pcall(vim.cmd, "silent! tabonly")

  -- 3) Make sure there’s only one window in this tab
  pcall(vim.cmd, "silent! only")

  -- 4) Wipe ALL buffers except the current one
  local cur = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= cur then
      pcall(vim.api.nvim_buf_delete, buf, { force = true })
    end
  end

  -- 5) Turn the current buffer into a scratch, unlisted buffer
  --    so it won't interfere with sessions
  pcall(function()
    vim.bo[cur].bufhidden = "wipe"
    vim.bo[cur].buflisted = false
    vim.bo[cur].buftype = "nofile"
    vim.bo[cur].swapfile = false
    vim.cmd("file __project_switch_scratch__")
  end)

  -- 6) Final redraw to stabilize UI before sourcing
  pcall(vim.cmd, "silent! redraw")
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
-- 🔁 Handle session switching and loading
-----------------------------------------------------------------------
function M.handleSession(name, dir)
  -- Save current project before switching
  if M.currentProject then
    M.saveSession(M.currentProject.name)
  end

  -- Clean everything (tabs, windows, buffers) but keep 1 scratch
  clean_ui_state()

  -- Change working directory to the new project
  if dir and dir ~= "" then
    vim.fn.chdir(vim.fn.expand(dir))
  end

  -- Load or create the new session
  local session = M.sessionDir .. "/" .. name .. ".vim"
  if vim.fn.filereadable(session) == 1 then
    -- Source the session (will open its own tabs/windows/buffers)
    vim.cmd("silent! source " .. vim.fn.fnameescape(session))
  else
    -- If no session exists yet, create one from the (empty) state in the project dir
    vim.cmd("mksession! " .. vim.fn.fnameescape(session))
  end

  if M.opts.open_tree then
    require("snacks").explorer.open()
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

vim.api.nvim_create_user_command("ProjectToggleOpenTree", function()
  M.opts.open_tree = not M.opts.open_tree

  vim.notify("Tree view value =" .. tostring(M.opts.open_tree), vim.log.levels.WARN, { title = "Project" })
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
