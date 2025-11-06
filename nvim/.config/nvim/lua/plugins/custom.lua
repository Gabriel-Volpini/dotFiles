local defaultDir = vim.fn.stdpath("config") .. "/lua/custom/"

return {
  {
    name = "Project Manager",
    dir = defaultDir .. "/project",
    config = function()
      require("custom.project").setup({
        projects = {
          { name = "DT - Backend - Deliveries Api", dir = "~/Documents/deliverThat/Delivery-API/apps/deliveries-api/" },
          { name = "DT - Backend - Hermes", dir = "~/Documents/deliverThat/Delivery-API/apps/hermes/" },
          { name = "DT - Backend - Root", dir = "~/Documents/deliverThat/Delivery-API/" },
          { name = "DT - Frontend - Mobile App", dir = "~/Documents/deliverThat/DeliverThat-rn/" },
          { name = "Memora", dir = "~/Documents/private_repos/LifeApp/mobile/" },
          { name = "Settings", dir = "~/Documents/dotFiles/nvim/.config/nvim/" },
          { name = "Project sessions", dir = "/Users/gabrielvolpini/.local/share/nvim/project_sessions" },
          { name = "Opencode agents", dir = "~/.config/opencode/agent/" },
        },
      })
    end,
  },
}
