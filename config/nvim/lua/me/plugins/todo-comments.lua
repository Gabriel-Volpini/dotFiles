return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		keywords = {
			FIX = {
				icon = " ", -- icon used for the sign, and in search results
				color = "error", -- can be a hex color, or a named color (see below)
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
				-- signs = false, -- configure signs for some keywords individually
			},
			TODO = { icon = "", color = "todo" },
			DONE = { icon = "󰱒 ", color = "done" },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			ERROR = { icon = " ", color = "error" },
			NOTE = { icon = " ", color = "note" },
		},
		colors = {
			error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
			warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
			todo = { "DiagnosticInfo", "#2563EB" },
			done = { "DiagnosticHint", "#10B981" },
			default = { "Identifier", "#7C3AED" },
			note = { "Identifier", "#FF00FF" },
		},
	},
	-- :TodoTelescope keywords=TODO,FIX
}
