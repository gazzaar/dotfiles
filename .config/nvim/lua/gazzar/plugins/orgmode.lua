return {
	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	ft = { "org" },
	config = function()
		-- Setup orgmode
		require("orgmode").setup({
			org_agenda_files = "~/.nb/klog/**/*",
			org_default_notes_file = "~/.nb/klog/area/log.org",
			org_capture_templates = {
				i = {
					description = "Ideas",
					template = "%?\n  %u\n\n",
					target = "~/.nb/klog/area/ideas.org",
					properties = {
						empty_lines = {
							before = 1,
							after = 1,
						},
					},
				},
				l = {
					description = "Quick Links",
					template = "- [[%x][%?]]\n  %u\n",
					target = "~/.nb/klog/resources/links.org",
					properties = {
						empty_lines = {
							before = 1,
							after = 1,
						},
					},
				},
				-- m = {
				-- 	description = "Multiple Todos",
				-- 	template = "* TODO Math: %?\n  %t\n* TODO CS: %?\n  %t\n* TODO Web: %?\n  %t\n* TODO Quran: %?\n  %t\n* TODO Misc: %?\n  %t\n",
				-- 	target = "~/.nb/klog/area/log.org",
				-- 	properties = {
				-- 		empty_lines = {
				-- 			before = 1,
				-- 			after = 1,
				-- 		},
				-- 	},
				-- },
			},
		})
	end,
}
