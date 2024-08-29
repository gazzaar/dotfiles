return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
  .--./)                                                               
 /.''\\                                                       .-,.--.  
| |  | |      __                              __        __    |  .-. | 
 \`-' /    .:--.'.  .--------. .--------.  .:--.'.   .:--.'.  | |  | | 
 /("'`    / |   \ | |____    | |____    | / |   \ | / |   \ | | |  | | 
 \ '---.  `" __ | |     /   /      /   /  `" __ | | `" __ | | | |  '-  
  /'""'.\  .'.''| |   .'   /     .'   /    .'.''| |  .'.''| | | |      
 ||     ||/ /   | |_ /    /___  /    /___ / /   | |_/ /   | |_| |      
 \'. __// \ \._,\ '/|         ||         |\ \._,\ '/\ \._,\ '/|_|      
  `'---'   `--'  `" |_________||_________| `--'  `"  `--'  `"          

      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
}
