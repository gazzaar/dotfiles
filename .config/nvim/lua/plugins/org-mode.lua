return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  ft = { "org" },
  config = function()
    local colors = require("tokyonight.colors").setup({ style = "moon" })
    require("orgmode").setup({
      org_agenda_files = "~/.nb/klog/**/*",
      org_default_notes_file = "~/.nb/klog/area/log.org",
      org_todo_keywords = { "TODO(t)", "|", "DONE", "CANCELED", "FAILED", "SIMIDONE" },
      org_todo_keyword_faces = {
        TODO = ":foreground " .. colors.orange .. " :weight bold",
        DONE = ":foreground " .. colors.blue .. " :weight bold",
        CANCELED = ":foreground " .. colors.purple .. " :weight bold",
        FAILED = ":foreground " .. colors.red .. " :weight bold",
        SIMIDONE = ":foreground " .. colors.green .. " :weight bold",
      },
      org_hide_emphasis_markers = true,
      org_startup_indented = false,
      org_adapt_indentation = false,

      org_capture_templates = {
        i = {
          description = "Ideas",
          template = "* %?\n  %u\n\n",
          target = "~/.nb/klog/area/ideas.org",
          -- properties = {
          -- 	empty_lines = {
          -- 		before = 1,
          -- 		after = 1,
          -- 	},
          -- },
        },
        l = {
          description = "Quick Links",
          template = "* [[%x][%?]]\n  %u\n",
          target = "~/.nb/klog/resources/links.org",
          -- properties = {
          -- 	empty_lines = {
          -- 		before = 1,
          -- 		after = 1,
          -- 	},
          -- },
        },
      },
    })
  end,
}
