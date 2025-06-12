return {
	"folke/which-key.nvim",
	name = "which-key",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
}
