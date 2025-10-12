-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- local discipline = require("gazzaar.discipline")
-- discipline.cowboy()
vim.api.nvim_set_keymap("n", ",", ":", { noremap = true })
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
-- take a screenshot of selection with ctrl-t
vim.keymap.set(
  "v",
  "<C-t>",
  ":Silicon<CR>",
  { noremap = false, silent = false, desc = "[t]ake screenshot from selection" }
)
-- increment/decrement numbers
-- vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
-- vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement
-- Map 'jj' to escape insert mode let's see it again
