-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Quicker close split
vim.keymap.set("n", "<leader>qq", ":q<CR>",
  {silent = true, noremap = true}
)

-- clear the command line and search highlighting
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- window management
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
vim.keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
vim.keymap.set("n", "<leader>wd", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
vim.keymap.set("n", "<leader>wq", ":vertical resize -10<CR>", {noremap=true})
vim.keymap.set("n", "<leader>we", ":vertical resize +10<CR>", {noremap=true})
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Mode to window to the left"})
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Mode to window down"})
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Mode to window up"})
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Mode to window to the rght"})
