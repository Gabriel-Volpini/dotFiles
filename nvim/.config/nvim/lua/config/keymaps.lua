local helpers = require("plugins.custom.modules.Helpers")
------------------------------------------------------------------
helpers.destroy_keymap({
  n = {
    { "<leader>E", "Snack Explorer" },
    { "<leader>e", "Snack Explorer" },
    { "<leader>uh", "UI -  Inlay hints" },
    { "<leader>ul", "UI - Line numbers" },
  },
})

vim.keymap.set("n", "<leader>ff", function()
  require("snacks").picker.files({ cwd = vim.fn.getcwd() })
end, { desc = "Find files (Snacks)" })

vim.keymap.set("n", "<leader>e", function()
  Snacks.explorer.open({ cwd = vim.fn.getcwd() })
end, { desc = "File explorerfiles (Snacks)" })

--buffer navigation
vim.keymap.set("n", "<leader><leader>", "<cmd>e #<CR>", { desc = "Switch to previous buffer" })
-- vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
-- vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
