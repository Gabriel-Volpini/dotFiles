local Split = require("nui.split")

local M = {}

local split = Split({
  position = "left",
  size = "35%",
  relative = "editor",
  enter = false,
  win_options = {
    cursorline = false,
    number = false,
    relativenumber = false,
    signcolumn = "no",
    foldcolumn = "0",
  },
  buf_options = {
    modifiable = false,
    readonly = true,
  },
})

split:mount()

return M
