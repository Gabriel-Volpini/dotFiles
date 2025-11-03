return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      enabled = true,
      layouts = {
        default = {
          layout = { width = 70 },
        },
      },
    },

    -- 👇 add this block
    explorer = {
      enabled = true,
      watch = {
        enabled = false, -- hotfix: avoid vim.tbl_values(nil) in watch.lua
      },
    },
  },
}
