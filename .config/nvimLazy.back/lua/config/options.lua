-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.colorcolumn = "80"
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  -- command = "highlight ColorColumn ctermbg=0 guibg=#2F334D",
  command = "highlight ColorColumn ctermbg=0 guibg=#3C3836",
})
