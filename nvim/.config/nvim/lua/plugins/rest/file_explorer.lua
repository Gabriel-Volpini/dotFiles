return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	lazy = false, -- neo-tree will lazily load itself
	keys = {
		{
			"<leader>ee",
			"<cmd>Neotree reveal<CR>",
			desc = "Open float file explorer",
		},
	},
	opts = {
		window = {
			position = "float",
			popup = {
				size = {
					height = "65%", -- ou número absoluto
					width = "55%", --35
				},
				position = "50%", -- centralizado
			},
			mappings = {
				["q"] = "close_window",
				-- ["z"] = "collapse_all_nodes"
			},
		},
		default_component_configs = {
			git_status = {
				symbols = {
					added = "Added", -- plus
					modified = "Modified", -- dot
					deleted = "Deleted", -- trash
					renamed = "Renamed", -- arrow
					untracked = "Untracked", -- question
					ignored = "Ignored", -- eye
					unstaged = "", -- exclamation
					staged = "", -- check
					conflict = "Conflict", -- git merge
				},
			},
		},
	},
}
