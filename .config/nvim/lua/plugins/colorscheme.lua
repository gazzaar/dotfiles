return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000, -- make sure to load this before all the other start plugins
  --
  config = function()
    require("gruvbox").setup({
      transparent_mode = false,
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("gruvbox")
  end,
}
