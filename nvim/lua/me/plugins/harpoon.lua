return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		local wk = require("which-key")
		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
			},
		})

		wk.register({
			["<leader>"] = {
				a = {
					function()
						harpoon:list():append()
					end,
					"Harpoon append",
				},
				["hl"] = {
					function()
						harpoon.ui:toggle_quick_menu(harpoon:list())
					end,
					"Harpoon show list",
				},
			},
			["<leader>1"] = {
				function()
					harpoon:list():select(1)
				end,
				"Harpoon first item",
			},
			["<leader>2"] = {
				function()
					harpoon:list():select(2)
				end,
				"Harpoon second item",
			},
			["<leader>3"] = {
				function()
					harpoon:list():select(3)
				end,
				"Harpoon third item",
			},
			["<leader>4"] = {
				function()
					harpoon:list():select(4)
				end,
				"Harpoon fourth item",
			},
		})

		-- Toggle previous & next buffers stored within Harpoon list
		-- vim.keymap.set("n", "<C-S-P>", function()
		-- end)
		-- vim.keymap.set("n", "<C-S-N>", function()
		-- 	harpoon:list():next()
		-- end)
	end,
}
