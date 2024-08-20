return {
	"numToStr/FTerm.nvim",
	config = function()
		require("FTerm").setup({
			dimensions = {
				height = 0.8,
				width = 0.8,
				x = 0.5,
				y = 0.5,
			},
			border = "single",
		})
	end,
	keys = {
		{
			"<leader>gg",
			function()
				local term = require("FTerm.terminal")
				local lazy = term:new():setup({ cmd = "lazygit" })
				lazy:toggle()
			end,
		},
		{
			"<C-t>",
			"<cmd>lua require('FTerm').toggle()<CR>",
		},
	},
}
