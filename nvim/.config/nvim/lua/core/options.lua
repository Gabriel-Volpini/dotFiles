local opt = vim.opt 

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 4 
opt.softtabstop = 4
opt.shiftwidth = 4 
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true 
opt.incsearch = true
opt.smartcase = false -- if you include mixed case in your search, assumes you want case-sensitive


-- files
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- appearance
opt.termguicolors = true
opt.background = "dark" 
opt.signcolumn = "yes" -- show sign column so that text doesn't shift
opt.scrolloff = 8 -- Always keep 8 lines above/below cursor unless at start/end of file
opt.hlsearch = true

opt.backspace = {"indent","eol","start"} -- allow backspace on indent, end of line or insert mode start position


-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

opt.isfname:append("@-@")
opt.updatetime = 50
-- opt.colorcolumn= "100"

opt.mouse = "a"
vim.g.editorconfig = true

--hilight when yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "highlight when yaking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

