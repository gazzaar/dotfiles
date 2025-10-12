return {
  "chipsenkbeil/org-roam.nvim",
  enabled = false,
  tag = "0.1.0",
  ft = { "org" }, -- only load for Org files
  dependencies = {
    "nvim-orgmode/orgmode",
  },
  config = function()
    require("org-roam").setup({
      directory = "~/.nb/klog/resources/room/",
      -- optional
      org_files = {
        "~/.nb/klog/**/*.org",
      },
    })
  end,
}
