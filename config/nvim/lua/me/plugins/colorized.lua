return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		local colorizer = require("colorizer")
		colorizer.setup({
			"css",
			"javascript",
			"lua",
			html = { mode = "background" },
		}, { mode = "background" })
	end,
}
