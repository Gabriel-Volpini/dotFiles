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

function M.getPickerItems()
  if M.currentProject then
    return vim.tbl_filter(function(item)
      return item.name ~= M.currentProject.name
    end, M.opts.projects)
  else
    return M.opts.projects
  end
end

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

function M.close_all_buffers()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end

function M.saveSession(name)
  vim.fn.mkdir(M.sessionDir, "p")
  local session = M.sessionDir .. "/" .. name .. ".vim"
  vim.cmd("mksession! " .. vim.fn.fnameescape(session))
  vim.notify("💾 Saved session for " .. name, vim.log.levels.INFO, { title = "Project" })
end

function M.handleSession(name, dir)
  -- save current project before switching
  if M.currentProject then
    M.saveSession(M.currentProject.name)
  end

  -- close all buffers
  -- M.close_all_buffers()

  local session = M.sessionDir .. "/" .. name .. ".vim"
  if vim.fn.filereadable(session) == 1 then
    vim.cmd("silent! source " .. vim.fn.fnameescape(session))
  else
    vim.fn.chdir(vim.fn.expand(dir))
    vim.cmd("mksession! " .. vim.fn.fnameescape(session))
  end

  vim.api.nvim_echo({
    { "Switched to ", "Normal" },
    { name, "String" },
  }, false, {})

  M.currentProject = { name = name, dir = dir }
end

vim.api.nvim_create_user_command("ProjectSelect", function()
  M.select()
end, { desc = "Select a project" })

vim.api.nvim_create_user_command("ProjectSave", function()
  M.saveSession(M.currentProject.name)
end, { desc = "Save a project" })

return M
--TODO: Save file tree state
--TODO: Change tree directory if open
--TODO: Buffer navigate
