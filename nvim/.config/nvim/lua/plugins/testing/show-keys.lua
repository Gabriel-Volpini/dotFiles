
return {
  "nvzone/showkeys",
  config = function()
    local showkey = require("showkeys")

    showkey.setup({
        timeout = 1,
        maxkeys = 5,
        show_count = true
        -- more opts
      })

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        showkey.toggle()
      end,
    })
  end
}
