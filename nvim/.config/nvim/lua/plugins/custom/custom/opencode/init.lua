--TODO: Moev project plugin to git so it can be installed via lazy?
--TODO: Modularize and move inside the project plugin
--TODO: fix visual selection with vif inner funcion
--

local M = {}
M.terminal = Snacks.terminal.open("opencode --agent Lua")
M.terminal:hide()

function M.toggleTerminal(message)
  -- TODO: use the buf to validate if it needs to re run the opencode comand and kill the terminal if is not snacks terminal anymore
  -- M.terminal.buf
  M.terminal:toggle()
  if not M.terminal.closed then
    --avoid the strange cursor placement
    vim.api.nvim_feedkeys("w", "n", false)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<BS>", true, false, true), "n", false)
  end
  if message then
    vim.api.nvim_feedkeys(message, "i", false)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "i", false)
  end
end

function M.openFloatQuestion()
  local selection = Utils.get_visual_selection()
  -- Utils.debug(selection)
  -- if true then
  --   return
  -- end

  vim.ui.input({
    prompt = "Ask opencode: ",
    default = "",
    icon = " ",
    win = {
      row = 0,
      col = 0,
      relative = "cursor",
      anchor = "SW",
      width = 40,
    },
  }, function(input)
    if input and input ~= "" then
      -- Escape special characters in selection for shell command
      local question = input .. '\n---\n"' .. selection

      M.toggleTerminal(question)
    end
  end)
end

vim.keymap.set({ "n", "t" }, "<C-t>", function()
  M.toggleTerminal()
end, { desc = "Open opencode terminal (Snacks)" })

vim.keymap.set({ "v", "x", "n" }, "<leader>ww", function()
  M.openFloatQuestion()
  -- Utils.debug(M.terminal)
end, { desc = "Open opencode terminal (Snacks)" })
