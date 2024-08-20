return {
	"shortcuts/no-neck-pain.nvim",
	config = function()
		require("no-neck-pain").setup({
			width = 100,
			autocmds = {
				enableOnVimEnter = false,
			},
			buffers = {
				scratchPad = {
					enabled = false,
					location = nil,
				},
				bo = {
					filetype = "md",
				},
			},
		})
	end,
}
