return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = function()
      local logo = [[
  __ _   __ _  ____ ____ __ _   __ _  _ __ 
 / _` | / _` ||_  /|_  // _` | / _` || '__|
| (_| || (_| | / /  / /| (_| || (_| || |   
 \__, | \__,_|/___|/___|\__,_| \__,_||_|   
  __/ |                                    
 |___/                                     
      ]]

      return {
        dashboard = {
          enabled = true,
          preset = {
            header = logo,
          },
        },

        bigfile = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
      }
    end,
  },
}
