local M = {}

M.term = require("plugins.custom.modules.Projects.opencode.components.split_terminal")

M.term.setup({
  ag = "Lua",
  toggleKeyMap = "<C-t>",
})

return M.term.bufnr
