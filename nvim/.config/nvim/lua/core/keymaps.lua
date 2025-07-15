local keymap = vim.keymap 

vim.g.mapleader = " "

keymap.set("n", "<C-q>", "<cmd>qa<CR>", { desc = "Quit nvim" })


vim.keymap.set("v", "K", ":move '<-2<CR>gv=gv", { desc = "Move selected lines up" })
vim.keymap.set("v", "J", ":move '>+1<CR>gv=gv", { desc = "Move selected lines down" })

keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down in a buffer and centers the cursor" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move down in a buffer and centers the cursor" })

keymap.set("n", "n", "nzzzv", { desc = "Go to next search centered" })
keymap.set("n", "N", "Nzzzv", { desc = "Go to previous search centered" })

keymap.set("v", "<", "<gv", { desc = "Ident left", noremap = true, silent = true })
keymap.set("v", ">", ">gv", { desc = "Ident right", noremap = true, silent = true })

keymap.set({"x", "v"}, "p", [["_dP]], { desc = "Paste in visual mode without copying it", noremap = true, silent = true })
keymap.set("n", "x", '"_x',{ desc = "Delete single char without copying it", noremap = true, silent = true })

keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlights" , silent = true})

keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format buffer using lsp" })

keymap.set("n", "Q", "<nop>", { desc = "Disable old vim command mode" })

keymap.set({"i", "v", "n"}, "<C-s>", "<Esc>:w<CR>", {desc = "Save file", noremap = true, silent = true})

keymap.set({"n","v"}, "<leader>s", ":s/", { desc = "Start replace comand" })

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })     
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })   
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })      
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) 

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) 
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) 
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) 
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) 
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) 

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

--Alternar entre buffers
vim.api.nvim_set_keymap("n", "<leader><leader>", "<cmd>b#<CR>", { noremap = true })

--usar jq para formatar arquivo json
vim.keymap.set("n", "gj", "<cmd>%!jq '.'<cr>", { noremap = true, silent = true })


