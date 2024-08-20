-- Buffed Print
P = function(v)
	local inspected_data = vim.inspect(v)

	local lines = {}
	for s in inspected_data:gmatch("[^\r\n]+") do
		table.insert(lines, s)
	end
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	vim.api.nvim_buf_set_option(buf, "buflisted", false)

	-- Abre o buffer na nova janela dividida
	vim.cmd("sp")
	local win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(win, buf)
end

-- Função para obter as linhas selecionadas no modo visual
Get_selected_lines = function()
	local buf = vim.api.nvim_get_current_buf()
	-- Pega as posições de marcação inicial e final da seleção visual
	local start_mark = vim.fn.getpos("'<")
	local end_mark = vim.fn.getpos("'>")

	-- Extrai o número da linha inicial e final
	local start_line = start_mark[2]
	local end_line = end_mark[2]

	-- Lista para armazenar as linhas selecionadas
	local selected_lines = {}
	local index = 1
	-- Loop através das linhas selecionadas
	for line_number = start_line, end_line do
		-- Obtém o conteúdo da linha atual
		local line_content = vim.api.nvim_buf_get_lines(buf, line_number - 1, line_number, false)[1]

		-- Adiciona a linha ao resultado
		table.insert(selected_lines, tostring(index) .. ". " .. line_content)
		index = index + 1
	end

	vim.api.nvim_buf_set_lines(buf, start_line - 1, end_line, false, selected_lines)
	-- return { selected_lines, start_line, end_line }
end
