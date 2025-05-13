-- set leader key to space
vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness
-- General Keymaps -------------------

keymap.set("n", "<C-q>", "<cmd>qa<CR>", { desc = "Quit nvim" })

-- use jk to exit insert mode
keymap.set("i", "hj", "<ESC>", { desc = "Exit insert mode and save" })
keymap.set("i", "jh", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("i", "hh", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- using ctrl s for saving
keymap.set("i", "<C-s>", "<Esc>:silent w<CR>")
keymap.set("n", "<C-s>", "<Esc>:silent w<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
-- keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
-- keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
-- keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- keymap.set("n", "<cr>", "<cmd>normal! o<cr> | <cmd>stopinsert<cr>")
-- keymap.set("n", "<S-Enter>", "<cmd>normal! O<cr> | <cmd>stopinsert<cr>")

-- Terminal
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true }) --use Esc to exit terminal mode
vim.api.nvim_set_keymap("t", "<A-h>", "<C-\\><C-N><C-w>h", { noremap = true })
vim.api.nvim_set_keymap("t", "<A-j>", "<C-\\><C-N><C-w>j", { noremap = true })
vim.api.nvim_set_keymap("t", "<A-k>", "<C-\\><C-N><C-w>k", { noremap = true })
vim.api.nvim_set_keymap("t", "<A-l>", "<C-\\><C-N><C-w>l", { noremap = true })
vim.api.nvim_set_keymap("i", "<A-h>", "<C-\\><C-N><C-w>h", { noremap = true })
vim.api.nvim_set_keymap("i", "<A-j>", "<C-\\><C-N><C-w>j", { noremap = true })
vim.api.nvim_set_keymap("i", "<A-k>", "<C-\\><C-N><C-w>k", { noremap = true })
vim.api.nvim_set_keymap("i", "<A-l>", "<C-\\><C-N><C-w>l", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-h>", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-j>", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-k>", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-l>", "<C-w>l", { noremap = true })

--Buffer
vim.api.nvim_set_keymap("n", "<leader><leader>", "<cmd>b#<CR>", { noremap = true })
