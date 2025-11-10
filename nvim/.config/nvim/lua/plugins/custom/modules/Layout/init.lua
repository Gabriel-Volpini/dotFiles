local Split = require("nui.split")
local event = require("nui.utils.autocmd").event

local M = {}

function M.setup()
  require("catppuccin").setup({
    flavour = "macchiato",
    transparent_background = true,
  })
  vim.cmd.colorscheme("catppuccin")

  vim.opt.fillchars = {
    vert = " ",
    horiz = " ",
    horizup = " ",
    horizdown = " ",
    vertleft = " ",
    vertright = " ",
    verthoriz = " ",
  }
  vim.opt.fillchars:append({ eob = " " })

  local ok, cat = pcall(require, "catppuccin.palettes")
  local base = "#1e1e2e" -- fallback
  local border = "#313244"

  if ok then
    local p = cat.get_palette("macchiato")
    base = p.base
    border = p.surface1
  end

  vim.api.nvim_set_hl(0, "SolidWindow", { bg = base })
  vim.api.nvim_set_hl(0, "SolidBorder", { bg = base, fg = border })

  local lualine = require("lualine")
  local cfg = lualine.get_config()

  table.insert(cfg.sections.lualine_a, 1, {
    function()
      local width = vim.o.columns
      local main_width = math.floor(width * 0.64)
      local filler = math.max(width - main_width, 0)
      return string.rep(" ", filler)
    end,
    color = { bg = "none", fg = "none" },
    padding = 0,
  })

  lualine.setup(cfg)
end

function M.apply_solid_bg(winid)
  vim.api.nvim_set_option_value("winhighlight", "Normal:SolidWindow,FloatBorder:SolidBorder", { win = winid })
end

M.setup()

local left = Split({
  position = "left",
  size = "35%",
  relative = "editor",
  enter = false,
  win_options = {
    cursorline = false,
    number = false,
    relativenumber = false,
    signcolumn = "no",
    foldcolumn = "0",
  },
  buf_options = {
    modifiable = false,
    readonly = true,
  },
})

left:mount()
left:map("n", "q", function()
  left:unmount()
end)

local Layout = require("nui.layout")
local Popup = require("nui.popup")

local left_popup = Popup({
  border = { style = "rounded", text = { top = "CPU / Memory" } },
})
local left_popup1 = Popup({
  border = { style = "rounded", text = { top = "Marks" } },
})
local left_popup2 = Popup({
  border = { style = "rounded", text = { top = "Todo's" } },
})

local right_popup = Popup({
  border = { style = "rounded", text = { top = "Right" } },
})

local function make_spacer(width, height)
  return Popup({
    size = { width = width, height = height },
    focusable = false,
    border = { style = "none" },
    win_options = {
      winhighlight = "Normal:Normal",
    },
  })
end

local hspacer = make_spacer(2, "100%")

local leftBox = Layout.Box({
  Layout.Box(left_popup, {
    size = { width = "100%", height = "33%", border = {
      padding = {
        bottom = 10,
      },
    } },
  }),
  Layout.Box(make_spacer("100%", 1), { size = 1 }),
  Layout.Box(left_popup1, {
    size = { width = "100%", height = "33%" },
  }),
  Layout.Box(make_spacer("100%", 1), { size = 1 }),
  Layout.Box(left_popup2, {
    size = { width = "100%", height = "33%" },
  }),
}, { dir = "col", size = "50%" })

local layout = Layout(
  {
    relative = {
      type = "win", -- 👈 relative to the split's window
      winid = left.winid,
    },
    position = { row = 0, col = 0 }, --row = 2 para ir em cima da lualine
    size = { width = "100%", height = "100%" },
  },
  Layout.Box({
    leftBox,
    Layout.Box(hspacer, { size = 2 }), -- 👈 GAP
    Layout.Box(right_popup, { size = "50%" }),
  }, { dir = "row" })
)

layout:mount()

local right = Split({
  position = "right",
  size = "20%",
  relative = "editor",
  enter = false,
  win_options = {
    cursorline = false,
    number = false,
    relativenumber = false,
    signcolumn = "no",
    foldcolumn = "0",
  },
  buf_options = {
    modifiable = false,
    readonly = true,
  },
})

right:mount()
right:map("n", "q", function()
  right:unmount()
end)

M.apply_solid_bg(right.winid)
