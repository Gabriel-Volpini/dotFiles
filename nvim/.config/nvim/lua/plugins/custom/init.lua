local M = {}

function M.setup()
  ------------------------------------------------------------------
  local helpers = require("plugins.custom.modules.Helpers")
  ------------------------------------------------------------------
  vim.keymap.set("n", "<leader>r", helpers.run_and_show, { desc = "Run Lua file and display return value" })

  ------------------------------------------------------------------
  local projects = require("plugins.custom.modules.Projects")
  ------------------------------------------------------------------
  projects.setup({
    projects = {
      { name = "DT - Backend - Deliveries Api", dir = "~/Documents/deliverThat/Delivery-API/apps/deliveries-api/" },
      { name = "DT - Backend - Hermes", dir = "~/Documents/deliverThat/Delivery-API/apps/hermes/" },
      { name = "DT - Backend - Root", dir = "~/Documents/deliverThat/Delivery-API/" },
      { name = "DT - Frontend - Mobile App", dir = "~/Documents/deliverThat/DeliverThat-rn/" },
      { name = "Memora", dir = "~/Documents/private_repos/LifeApp/mobile/" },
      { name = "Settings", dir = "~/Documents/dotFiles/nvim/.config/nvim/lua/" },
      { name = "Project sessions", dir = "~/.local/share/nvim/project_sessions" },
      { name = "Opencode agents", dir = "~/.config/opencode/agent/" },
    },
  })

  vim.keymap.set("n", "<leader>p", "<cmd>ProjectSelect<CR>", { desc = "Select Project (Snacks)" })

  vim.keymap.set("n", "<C-q>", function()
    vim.cmd.ProjectSave()
    vim.cmd.qa()
  end, { desc = "Save project session and quit" })
end

return {
  name = "custom",
  dir = vim.fn.stdpath("config") .. "/lua/plugins/custom/",
  lazy = true,
  config = M.setup(),
}
