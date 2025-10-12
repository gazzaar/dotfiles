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
-- return {
--   "rose-pine/neovim",
--   name = "rose-pine",
--   config = function()
--     local rosePine = require("rose-pine")
--     rosePine.setup({
--
--       -- variant = "moon", -- Set variant
--       -- variant = "Dawn",
--       variant = "auto", -- auto, main, moon, or dawn
--       dark_variant = "moon",
--       styles = {
--         transparency = false,
--       },
--     })
--
--     vim.cmd("colorscheme rose-pine") -- This respects the variant you set in setup
--   end,
-- }
