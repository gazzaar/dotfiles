return {
	"chipsenkbeil/org-roam.nvim",
	tag = "0.1.0",
	dependencies = {
		{
			"nvim-orgmode/orgmode",
			tag = "0.3.4",
		},
	},
	config = function()
		require("org-roam").setup({
			directory = "~/.nb/klog/**/*",
			-- optional
			org_files = {
				-- "~/another_org_dir",
				-- "~/some/folder/*.org",
				-- "~/a/single/org_file.org",
			},
		})
	end,
}
