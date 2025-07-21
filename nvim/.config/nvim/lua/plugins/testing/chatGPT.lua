return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim", -- optional
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{
			"<leader>g",
			"<cmd>ChatGPT<CR>",
			mode = "n",
			desc = "Open ChatGPT",
		},
		{
			"<leader>g",
			"<cmd>ChatGPTEditWithInstruction<CR>",
			mode = "v",
			desc = "Open ChatGPT wiht selected code",
		},
	},
	config = function()
		require("chatgpt").setup({
			api_key_cmd = "tr -d '\\n' < /Users/gabrielvolpini/Documents/dotFiles/secrets/openai.txt",
			openai_params = {
				model = "gpt-4.1-mini",
				temperature = 0.3,
				max_tokens = 2000,
			},
			popup_window = {
				win_options = {
					winhighlight = "Normal:ChatGPTFloat,FloatBorder:ChatGPTFloatBorder",
				},
			},
			popup_input = {
				win_options = {
					winhighlight = "Normal:ChatGPTFloat,FloatBorder:ChatGPTFloatBorder",
				},
			},
			system_window = {
				win_options = {
					winhighlight = "Normal:ChatGPTFloat,FloatBorder:ChatGPTFloatBorder",
				},
			},
			settings_window = {
				win_options = {
					winhighlight = "Normal:ChatGPTFloat,FloatBorder:ChatGPTFloatBorder",
				},
			},
			sessions_window = {
				win_options = {
					winhighlight = "Normal:ChatGPTFloat,FloatBorder:ChatGPTFloatBorder",
				},
			},
			help_window = {
				win_options = {
					winhighlight = "Normal:ChatGPTFloat,FloatBorder:ChatGPTFloatBorder",
				},
			},
		})
	end,
}
