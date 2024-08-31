return {
  {
    "folke/zen-mode.nvim",
    opts = {},
    config = function()
      require("zen-mode").setup({
        plugins = {
          -- disable some global vim options (vim.o...)
          -- comment the lines to not apply the options
          options = {
            enabled = true,
            ruler = false, -- disables the ruler text in the cmd line area
            showcmd = false, -- disables the command in the last line of the screen
            -- you may turn on/off statusline in zen mode by setting 'laststatus'
            -- statusline will be shown only if 'laststatus' == 3
            laststatus = 0, -- turn off the statusline in zen mode
          },
        },
        vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", { desc = "toggle zen mode" }),
      })
    end,
  },
  {
    "folke/twilight.nvim",
    opts = {},
  },
}
