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
  ___    __    ____  ____    __      __    ____ 
 / __)  /__\  (_   )(_   )  /__\    /__\  (  _ \
( (_-. /(__)\  / /_  / /_  /(__)\  /(__)\  )   /
 \___/(__)(__)(____)(____)(__)(__)(__)(__)(_)\_)
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
}
