--TODO: fix visual selection with vif inner funcion
local M = {}
M.terminal = Snacks.terminal.open("opencode --agent Lua")
M.terminal:hide()

function M.toggleTerminal(message)
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
  Utils.debug(selection)
  if true then
    return
  end

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

      Utils.debug(question)

      M.toggleTerminal(question)
    end
  end)
end

vim.keymap.set({ "n", "t" }, "<C-t>", function()
  M.toggleTerminal()
end, { desc = "Open opencode terminal (Snacks)" })

vim.keymap.set({ "v", "x", "n" }, "<leader>ww", function()
  M.openFloatQuestion()
end, { desc = "Open opencode terminal (Snacks)" })
