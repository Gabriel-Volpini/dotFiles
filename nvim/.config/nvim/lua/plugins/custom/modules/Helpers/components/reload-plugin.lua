local input

local function extract_require_path(str)
  return str:match('require%("([^"]+)"%)')
end

local function handlesubmit(str)
  local parsed = extract_require_path(str)
  package.loaded[parsed] = nil
  vim.notify("Plugin reseted", vim.log.levels.INFO)
end

local function open(string)
  local Input = require("nui.input")
  local event = require("nui.utils.autocmd").event

  input = Input({
    position = { row = "30%", col = "50%" },
    size = {
      width = 80,
    },
    border = {
      style = "single",
      text = {
        top = " Reload plugin ",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Type,FloatTitle:Type",
    },
    buf_options = {
      filetype = "lua",
    },
  }, {
    prompt = " 󰢱 ",
    default_value = string,
    on_submit = function(value)
      handlesubmit(value)
    end,
  })

  input:mount()

  input:on(event.BufEnter, function()
    vim.cmd("stopinsert")
  end)

  input:on(event.BufLeave, function()
    input:unmount()
  end)

  input:map("n", { "q", "<esc>" }, function()
    input:unmount()
  end)
end

return function()
  vim.cmd('noautocmd normal! "vy') -- yank before mode exit
  local text = vim.fn.getreg("v")
  text = text:match("([^\n]*)") or text
  open(text)
end
