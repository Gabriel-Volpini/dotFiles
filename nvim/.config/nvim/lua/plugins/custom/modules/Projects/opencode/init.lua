local M = {}

M.term = require("plugins.custom.modules.Projects.opencode.components.split_terminal")

M.term.setup({ ag = "Lua" })
M.term.toggle()

vim.keymap.set("n", "<leader>ww", function()
  Utils.debug(M.term.bufnr)
end)

return M.term.bufnr
