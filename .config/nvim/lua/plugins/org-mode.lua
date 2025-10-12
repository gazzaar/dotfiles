return {
  "nvim-orgmode/orgmode",
  enabled = true,
  event = "VeryLazy",
  ft = { "org" }, -- only load for Org files
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    -- local palette = require("rose-pine.palette")
    local gruvbox = require("gruvbox")
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

        -- rose-pine
        -- TODO = ":foreground " .. palette.gold .. " :weight bold",
        -- DONE = ":foreground " .. palette.foam .. " :weight bold",
        -- CANCELED = ":foreground " .. palette.muted .. " :weight bold",
        -- FAILED = ":foreground " .. palette.love .. " :weight bold",
        -- SIMIDONE = ":foreground " .. palette.leaf .. " :weight bold",
        -- ALLMOSTDONE = ":foreground " .. palette.iris .. " :weight bold",

        -- Gruv box theme
        TODO = ":foreground " .. gruvbox.palette.neutral_orange .. " :weight bold",
        DONE = ":foreground " .. gruvbox.palette.neutral_blue .. " :weight bold",
        CANCELED = ":foreground " .. gruvbox.palette.neutral_purple .. " :weight bold",
        FAILED = ":foreground " .. gruvbox.palette.neutral_red .. " :weight bold",
        SIMIDONE = ":foreground " .. gruvbox.palette.neutral_green .. " :weight bold",
        ALLMOSTDONE = ":foreground " .. gruvbox.palette.neutral_yellow .. " :weight bold",
      },
      org_startup_folded = "overview",
      org_folding_level = 0,
      org_hide_emphasis_markers = true,
      org_startup_indented = false,
      org_adapt_indentation = true,

      org_capture_templates = {
        i = {
          description = "Ideas",
          template = "* %?",
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
          template = "* [[%x][%?]]",
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
