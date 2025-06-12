return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
        require("neo-tree").setup({
            popup_border_style = "rounded",
			buffers = {
				follow_current_file = {
					enabled = true, 
					leave_dirs_open = true,
				},
			},
			window = {
				position = "float",
			},
        })
		vim.keymap.set("n", "<leader>ee", ":Neotree reveal<CR>", {})
		vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
	end,
}
