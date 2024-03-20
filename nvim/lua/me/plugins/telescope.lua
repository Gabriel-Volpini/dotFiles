return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local wk = require("which-key")
		local builtin = require("telescope.builtin")

		telescope.setup({
			pickers = {
				buffers = {
					initial_mode = "normal",
					attach_mappings = function(prompt_bufnr, map)
						local delete_buf = function()
							local selection = require("telescope.actions.state").get_selected_entry()
							actions.close(prompt_bufnr)
							vim.api.nvim_buf_delete(selection.bufnr, { force = true })
							builtin.buffers()
						end

						map("n", "d", delete_buf)

						return true
					end,
				},
			},
			defaults = {
				path_display = { "truncate " },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
					n = {
						["q"] = actions.close,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		wk.register({
			["<leader><leader>"] = {
				function()
					builtin.buffers({ sort_mru = true, ignore_current_buffer = true })
				end,
				"[F]ind buffers",
			},
			["<leader>f"] = {
				name = " [F]ind",
				h = { builtin.help_tags, "[F]ind [H]elp" },
				f = { builtin.find_files, "[F]ind [F]iles" },
				k = { builtin.keymaps, "[F]ind [K]eymaps" },
				s = { builtin.builtin, "[F]ind [S]elect Telescope" },
				c = { builtin.commands, "[F]ind commands" },
				w = { builtin.live_grep, "[F]ind words" },
				["<CR>"] = { builtin.resume, "Resume previous search" },
				["/"] = { builtin.current_buffer_fuzzy_find, "[F]ind words in current buffer" },
				n = {
					function()
						builtin.find_files({
							prompt_title = "Config Files",
							cwd = vim.fn.stdpath("config"),
							follow = true,
						}) -- call telescope
					end,
					"[F]indo config files",
				},
			},
		})
	end,
}
