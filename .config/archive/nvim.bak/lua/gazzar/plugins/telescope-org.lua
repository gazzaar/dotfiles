return {
	"nvim-orgmode/telescope-orgmode.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-orgmode/orgmode",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("telescope").load_extension("orgmode")

		vim.keymap.set(
			"n",
			"<leader>r",
			require("telescope").extensions.orgmode.refile_heading,
			{ desc = "Orgmode Refile" }
		)
		vim.keymap.set(
			"n",
			"<leader>fh",
			require("telescope").extensions.orgmode.search_headings,
			{ desc = "Orgmode Search Headings" }
		)
		vim.keymap.set(
			"n",
			"<leader>li",
			require("telescope").extensions.orgmode.insert_link,
			{ desc = "Orgmode insert link" }
		)
	end,
}
