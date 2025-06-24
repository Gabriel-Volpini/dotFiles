-- Truncate branch name
local function truncate_branch_name(branch)
  if not branch or branch == "" then
    return ""
  end

  local _, team, ticket_number = string.match(branch, "^(%w+)/(%w+)%-(%d+)")
  if ticket_number then
    return string.upper(team) .. "-" .. ticket_number
  else
    return branch
  end
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      icons_enabled = true,
      theme = "catppuccin",
      globalstatus = true,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {},
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        { "branch", fmt = truncate_branch_name },
        { "buffers" },
      },
      lualine_c = {
          {"%=", separator = ''} ,
          {"searchcount"},
      }, 
      lualine_x = { "selectioncount" },
      lualine_y = { "filetype", "datetime" },
      lualine_z = {"progress", "location"}, 
    },
  },
}
