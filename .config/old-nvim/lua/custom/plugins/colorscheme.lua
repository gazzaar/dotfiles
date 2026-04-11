return {

  {
    'sainnhe/gruvbox-material',
    config = function()
      vim.g.gruvbox_material_background = 'medium'
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },

  {

    'arcticicestudio/nord-vim',
    config = function()
      -- vim.cmd.colorscheme 'nord'
    end,
  },

  {
    'p00f/alabaster.nvim',
    url = 'https://git.sr.ht/~p00f/alabaster.nvim',
    config = function()
      vim.g.alabaster_dim_comments = true -- or false
      vim.g.alabaster_floatborder = false -- or false
      -- vim.cmd.colorscheme 'alabaster'
    end,
  },
}
