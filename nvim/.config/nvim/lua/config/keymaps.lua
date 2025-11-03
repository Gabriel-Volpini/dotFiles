-----------------------------------------------------------------------
--  DEBUG
-----------------------------------------------------------------------
vim.keymap.set("n", "<leader>r", function()
  local file = vim.fn.expand("%:p")
  if file:match("%.lua$") then
    dofile(file)
    vim.notify("✅ " .. vim.fn.fnamemodify(file, ":~") .. " executed", vim.log.levels.INFO, { title = "Lua Runner" })
  else
    vim.notify("⚠️ Not a Lua file!", vim.log.levels.WARN, { title = "Lua Runner" })
  end
end, { desc = "Run current Lua file" })

-----------------------------------------------------------------------
--  DELETING mappings
-----------------------------------------------------------------------

local unmap = { "<leader>E", "<leader>bb" }
for _, lhs in ipairs(unmap) do
  pcall(vim.keymap.del, "n", lhs)
end

-----------------------------------------------------------------------
--  NEW mappings
-----------------------------------------------------------------------

vim.keymap.set("n", "<leader>e", function()
  require("snacks").explorer.open()
end, { desc = "File explorerfiles (Snacks)" })

vim.keymap.set("n", "<leader>ff", function()
  require("snacks").picker.files({ cwd = vim.fn.getcwd() })
end, { desc = "Find files (Snacks)" })

--buffer navigation
vim.keymap.set("n", "<leader><leader>", "<cmd>e #<CR>", { desc = "Switch to previous buffer" })
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-----------------------------------------------------------------------
--  MY PLUGIN mappings
-----------------------------------------------------------------------

vim.keymap.set("n", "<leader>p", "<cmd>ProjectSelect<CR>", { desc = "Select Project (Snacks)" })

vim.keymap.set("n", "<C-q>", function()
  vim.cmd.ProjectSave() -- save session
  vim.cmd.qa() -- quit all windows cleanly
end, { desc = "Save project session and quit" })
