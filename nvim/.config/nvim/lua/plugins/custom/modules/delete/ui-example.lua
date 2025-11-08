local n = require("nui-components")
local width = math.floor(vim.o.columns * 0.8)
local height = math.floor(vim.o.lines * 0.8)
local renderer = n.create_renderer({
  width = width,
  height = height,
})
local signal = n.create_signal({
  chat = "",
  is_preview_visible = false,
})
local bufnr = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_call(bufnr, function()
  vim.fn.termopen(vim.o.shell) -- Replace 'bash' with your preferred shell
end)
local chan = vim.b[bufnr].terminal_job_id
if chan then
  vim.api.nvim_chan_send(chan, "opencode\n")
end

local body = function()
  return n.rows(
    n.text_input({
      border_label = "Chat",
      autofocus = true,
      wrap = true,
      on_change = function(value)
        signal.chat = value
      end,
    }),
    n.buffer({
      id = "preview",
      flex = 1,
      buf = bufnr,
      autoscroll = true,
      border_label = "Preview",
      hidden = signal.is_preview_visible:negate(),
    })
  )
end
renderer:add_mappings({
  {
    mode = { "n", "i" },
    key = "<CR>",
    handler = function()
      local state = signal:get_value()
      signal.is_preview_visible = true

      -- renderer:set_size({ height = height, width = width })

      renderer:schedule(function()
        local c = renderer:get_component_by_id("preview") or {}
        vim.api.nvim_win_set_buf(c.winid, bufnr)
        c:focus()
      end)
    end,
  },
})
renderer:render(body)
