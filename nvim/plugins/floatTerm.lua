return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			-- size can be a number or function(term)
			size = 20,
			open_mapping = [[<c-\>]],
			hide_numbers = true, -- hide the number column in toggleterm buffers
			shade_filetypes = {},
			start_in_insert = true,
			winhighlight = false,

			inert_mappings = true, -- whether or not the open mapping applies in insert mode
			persist_size = true,
			direction = "vertical",
			close_on_exit = true, -- close the terminal window when the process exits
			shell = vim.o.shell, -- change the default shell
			-- This field is only relevant if direction is set to 'float'
			float_opts = {
				border = "curved",
				width = 100,
				height = 30,
			},
		})

		--This make the naviation with vim motion btweeen terminals work
		function _G.set_terminal_keymaps()
			local opts = { noremap = true }
			vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
			-- vim.api.nvim_buf_set_keymap(0, "t", "hj", [[<C-\><C-n>]], opts)
			-- 	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
			-- 	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
			-- 	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
			-- 	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
		end
		-- if you only want these mappings for toggle term use term://*toggleterm#* instead
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

		local wk = require("which-key")
		wk.register({
			["<leader>gg"] = {
				function()
					local Terminal = require("toggleterm.terminal").Terminal
					local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
					lazygit:toggle()
				end,
				"Lazygit",
			},
			["<leader>t"] = {
				name = " Terminal",
				f = { "<cmd>ToggleTerm direction=float<cr>", "Float" }, -- Floating Terminal

				-- Play with size according to your needs.
				h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" }, -- Horizontal Terminal,
				v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" }, -- Vertical Terminal
			},
		})
	end,
}
