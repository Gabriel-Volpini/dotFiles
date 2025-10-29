vim.api.nvim_create_user_command("CopyFileName", function()
	local filename = vim.fn.expand("%:t") -- Only the file name
	vim.fn.setreg("+", filename) -- Copy to system clipboard
	print("Copied filename: " .. filename)
end, {})

vim.api.nvim_create_user_command("CopyFilePath", function()
	local filepath = vim.fn.expand("%:p") -- Full absolute path
	vim.fn.setreg("+", filepath)
	print("Copied full path: " .. filepath)
end, {})
