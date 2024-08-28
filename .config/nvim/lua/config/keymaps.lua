-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_set_keymap("n", ",", ":", { noremap = true })
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
-- increment/decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement
-- Map 'jj' to escape insert mode let's see it again
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true, silent = true })

-- Map 'jk' to save the file and exit insert mode
vim.api.nvim_set_keymap("i", "jk", "<Esc>:w<CR>", { noremap = true, silent = true })
