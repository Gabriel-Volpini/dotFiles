return {
	{
		"letieu/harpoon-lualine",
		dependencies = {
			"nvim-lualine/lualine.nvim",
			{
				"ThePrimeagen/harpoon",
				branch = "harpoon2",
			},
		},
	},

	{

		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
			local lualine = require("lualine")
			-- local harpoon = require("harpoon")

			local function truncate_branch_name(branch)
				if not branch or branch == "" then
					return ""
				end

				-- Match the branch name to the specified format
				local _, team, ticket_number = string.match(branch, "^(%w+)/(%w+)%-(%d+)")

				-- If the branch name matches the format, display {user}/{team}-{ticket_number}, otherwise display the full branch name
				if ticket_number then
					return string.upper(team) .. "-" .. ticket_number
				else
					return branch
				end
			end

			--
			-- 	if total_marks == 0 then
			-- 		return ""
			-- 	end
			--
			-- 	local current_mark = "—"
			-- 	local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
			--
			-- 	-- find active buffer index: https://github.com/ThePrimeagen/harpoon/issues/352#issuecomment-1873053256
			-- 	for index = 1, total_marks do
			-- 		local harpoon_file_path = harpoon:list():get(index).value
			--
			-- 		if current_file_path == harpoon_file_path then
			-- 			current_mark = tostring(index)
			-- 		end
			-- 	end
			--
			-- 	return string.format("󰛢 %s/%d", current_mark, total_marks)
			-- end

			lualine.setup({
				options = {
					icons_enabled = true,
					theme = "catppuccin",
					globalstatus = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						{ "branch", fmt = truncate_branch_name },

						{
							"filename",
							file_status = true, -- displays file status (readonly status, modified status)
							path = 4, -- 0 = just filename, 1 = relative path, 2 = absolute path
							symbols = {
								modified = "[Modified]", -- Text to show when the file is modified.
								readonly = "[Read only]", -- Text to show when the file is non-modifiable or readonly.
								unnamed = "[No Name]", -- Text to show for unnamed buffers.
								newfile = "[New]", -- Text to show for newly created file before first write
							},
						},
						"diff",
						"diagnostics",
					},
					lualine_c = {
						{
							"%=",
						},
						{
							"harpoon2",
							icon = "󰛢",
							indicators = { "1", "2", "3", "3" },
							active_indicators = { "[1]", "[2]", "[3]", "[4]" },
						},
					},
					lualine_x = {
						"filetype",
					},
					lualine_y = { "datetime" },
				},
			})
		end,
	},
}
