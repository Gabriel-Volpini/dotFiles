local Split = require("nui.split")
local event = require("nui.utils.autocmd").event

local split = Split({
  relative = "editor",
  position = "right",
  size = "50%",
})

split:mount()
local job_id

vim.api.nvim_buf_call(split.bufnr, function()
  job_id = vim.fn.jobstart({ "zsh", "-c", "opencode --agent Lua" }, {
    term = true,
    cwd = vim.fn.getcwd(),
    on_exit = function()
      split:unmount()
    end,
  })
  vim.cmd("startinsert")
end)

-- split:on(event.BufLeave, function()
--   split:hide()
-- end)
--
split:map("t", "<esc><esc>", function()
  vim.cmd("stopinsert")
end)

local open = true

vim.api.nvim_create_user_command("W", function()
  if open then
    split:hide()
  else
    split:show()
  end
  open = not open
end, { desc = "" })

vim.keymap.set("n", "<leader>ww", function()
  local se = Utils.get_visual_selection()
  Utils.debug(se)
  vim.fn.chansend(job_id, se)
end)

-- local NuiText = require("nui.text")
-- local NuiLine = require("nui.line")
--
-- local text_one = NuiText("One", "Error")
-- local text_two = NuiText("Two", "String")
-- local line = NuiLine({ text_one, text_two })
--
-- local bufnr, ns_id, linenr_start = 0, -1, 1
--
-- line:render(split.bufnr, ns_id, linenr_start)
-- line:render(split.bufnr, ns_id, linenr_start + 1)
-- line:render(split.bufnr, ns_id, linenr_start + 2)
