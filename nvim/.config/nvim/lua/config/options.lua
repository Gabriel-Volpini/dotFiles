-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.opt.splitkeep = "screen"

vim.lsp.inlay_hint.enable(false, { bufnr = nil }) -- disables globally

--TODO: descobrir como pegar a cor usando highlight goup
-- vim.defer_fn(function()
--   vim.api.nvim_set_hl(0, "WinSeparator", { link = "Number" })
--   vim.opt.fillchars = {
--     vert = "╻",
--     horiz = "╸",
--     horizup = "╋",
--     horizdown = "╋",
--     vertleft = "╋",
--     vertright = "╋",
--     verthoriz = "╋",
--   }
-- end, 100)
