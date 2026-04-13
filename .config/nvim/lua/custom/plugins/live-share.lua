return {
  'azratul/live-share.nvim',
  dependencies = {
    'jbyuki/instant.nvim',
  },
  config = function()
    vim.g.instant_username = 'your-username'
    require('live-share').setup {
      -- Add your configuration here
    }
  end,
}
