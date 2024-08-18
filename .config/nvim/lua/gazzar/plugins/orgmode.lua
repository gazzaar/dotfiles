return {
	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	ft = { "org" },
	config = function()
		-- Setup orgmode
		require("orgmode").setup({
			org_agenda_files = "~/.nb/klog/area/*",
			org_default_notes_file = "~/.nb/klog/area/log.org",
		})

		-- NOTE: If you are using nvim-treesitter with `ensure_installed = "all"` option
		-- add `org` to ignore_install
		-- require('nvim-treesitter.configs').setup({
		--   ensure_installed = 'all',
		--   ignore_install = { 'org' },
		-- })
	end,
}
