return {
  dir = "/Users/gabrielvolpini/Documents/private_repos/nvim-plugins", -- LOCAL plugin
  dev = true, -- important
  dependencies = {
    "folke/snacks.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local project = require("opencode")
    -- local project = require("teste")

    project.setup({})

    vim.keymap.set({ "n", "i", "v", "t" }, "<C-T>", "<CMD>ToggleOpencode<CR>")
    vim.keymap.set({ "n", "i", "v", "t" }, "<C-A>", "<CMD>AskOpencode<CR>")
  end,
}
