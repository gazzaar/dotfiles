return {
	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	ft = { "org" },
	config = function()
		-- Setup orgmode
		require("orgmode").setup({
			org_agenda_files = "~/.nb/klog/**/*",
			org_default_notes_file = "~/.nb/klog/area/log.org",
		})
	end,
}
