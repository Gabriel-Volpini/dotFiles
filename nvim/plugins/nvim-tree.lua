return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- change color for arrows in tree to light blue
		vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
		vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])
		-- configure nvim-tree
		nvimtree.setup({
			view = {
				width = 25,
				adaptive_size = true,
				relativenumber = true,
			},

			diagnostics = {
				enable = true,
				show_on_dirs = true,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			--Follow the current file
			update_focused_file = { enable = true },
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
					icons = {
						corner = "└ ",
						edge = "│ ",
						item = "│ ",
						none = "  ",
					},
				},
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
					glyphs = {
						folder = {
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							arrow_closed = "",
							arrow_open = "",
						},
						git = {
							unstaged = "", -- 
							staged = "",
							unmerged = "",
							renamed = "➜",
							-- untracked = "",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		-- set keymaps
		local wk = require("which-key")
		wk.register({
			["<leader>"] = {
				e = {
					name = " Exporer tree",
					e = { "<cmd>NvimTreeToggle<CR>", "Toggle file explorer" },
					o = { "<cmd>NvimTreeFocus<CR>", "Focus file explorer on current file" },
				},
			},
		})
	end,
}
