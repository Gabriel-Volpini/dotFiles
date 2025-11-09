local M = {}

M.term = require("plugins.custom.modules.Projects.opencode.components.split_terminal")

M.term.setup({ ag = "Lua" })

vim.keymap.set("n", "<C-t>", function()
  M.term.toggle()
end)

return M.term.bufnr
