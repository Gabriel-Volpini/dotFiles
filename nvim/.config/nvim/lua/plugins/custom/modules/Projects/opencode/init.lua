local M = {}

M.term = require("plugins.custom.modules.Projects.opencode.components.split_terminal")

---@param opts OpencodeOPTS
function M.setup(opts)
  M.term.setup(opts)
end

return M
