return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  ft = { "org" },
  config = function()
    local colors = require("tokyonight.colors").setup({ style = "moon" })
    require("orgmode").setup({
      org_agenda_files = "~/.nb/klog/**/*",
      org_default_notes_file = "~/.nb/klog/area/log.org",
      mappings = {
        org = {
          org_todo = "cot",
          org_todo_prev = "coT",
          org_toggle_checkbox = "<C-c>",
        },
      },
      org_todo_keywords = { "TODO(t)", "|", "DONE", "CANCELED", "FAILED", "SIMIDONE", "ALLMOSTDONE" },
      org_todo_keyword_faces = {
        TODO = ":foreground " .. colors.orange .. " :weight bold",
        DONE = ":foreground " .. colors.blue .. " :weight bold",
        CANCELED = ":foreground " .. colors.purple .. " :weight bold",
        FAILED = ":foreground " .. colors.red .. " :weight bold",
        SIMIDONE = ":foreground " .. colors.green .. " :weight bold",
        ALLMOSTDONE = ":foreground " .. colors.yellow .. " :weight bold",
      },
      org_hide_emphasis_markers = true,
      org_startup_indented = true,
      org_adapt_indentation = true,

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
