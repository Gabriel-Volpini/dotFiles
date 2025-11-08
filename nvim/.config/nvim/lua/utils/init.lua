-- lua/utils/init.lua
---@class Utils: any
local M = {}
-- Load submodules
M.debug = require("utils.debug")
M.get_visual_selection = require("utils.getVisualSelection")
M.show_highlight_colors = require("utils.showHighlightColors")
-- Set global access
_G.Utils = M
return M
