return {
	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	ft = { "org" },
	config = function()
		local gruvbox = require("gruvbox") -- Setup orgmode
		require("orgmode").setup({
			org_agenda_files = "~/.nb/klog/**/*",
			org_default_notes_file = "~/.nb/klog/area/log.org",
			org_todo_keywords = { "TODO(t)", "DONE", "CANCELED" },
			org_todo_keyword_faces = {
				TODO = ":foreground " .. gruvbox.palette.neutral_orange .. " :weight bold",
				DONE = ":foreground " .. gruvbox.palette.neutral_blue .. " :weight bold",
				CANCELED = ":foreground " .. gruvbox.palette.neutral_purple .. " :weight bold",
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
