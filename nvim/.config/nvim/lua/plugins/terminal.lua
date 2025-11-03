local function get_package_json_scripts()
  local cwd = vim.fn.getcwd()
  local path = cwd .. "/package.json"

  if vim.fn.filereadable(path) == 1 then
    local lines = table.concat(vim.fn.readfile(path), "\n")

    local ok, result = pcall(vim.fn.json_decode, lines)
    if not ok then
      vim.notify("Invalid JSON", vim.log.levels.ERROR)
      return nil
    end

    return result.scripts
  else
    vim.notify("package.json not found", vim.log.levels.ERROR)
    return nil
  end
end

local M = {}

M.terminals = {}
function M.create(name, cmd)
  local opts = cmd and { win = { position = "right", width = 0.2 } } or nil --ternario
  local term = Snacks.terminal.open(cmd, opts)

  vim.api.nvim_set_option_value("winbar", "  " .. name, { win = term.win })
  table.insert(M.terminals, term)
end

function M.toggleAll()
  for _, term in ipairs(M.terminals) do
    term:toggle()
  end
end

function M.open_terminal_and_run()
  local scripts = get_package_json_scripts()

  if not scripts then
    vim.notify("No scripts found", vim.log.levels.ERROR)
    return
  end

  local data = {}
  for key, value in pairs(scripts) do
    table.insert(data, { text = key, cmd = value })
  end

  Snacks.picker.select(data, {
    prompt = "Select project",
    format_item = function(item)
      return string.format("%s  →  %s", item.text, item.cmd)
    end,
  }, function(choice)
    if not choice then
      return
    end
    M.create(choice.text, "npm run " .. choice.text)
  end)
end

vim.keymap.set("n", "<leader>tt", function()
  vim.ui.input({ prompt = "Terminal name" }, function(value)
    if not value then
      return
    end
    M.create(value)
  end)
end)

vim.keymap.set("n", "<leader>tr", function()
  M.open_terminal_and_run()
end)
