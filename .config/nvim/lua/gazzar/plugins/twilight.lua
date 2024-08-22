return {
	"folke/twilight.nvim",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		dimming = {
			alpha = 0.25, -- amount of dimming
			-- we try to get the foreground from the highlight groups or fallback color
			-- color = { "Normal", "#ffffff" },
			-- term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
			-- inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
		},
	},
	vim.keymap.set("n", "<leader>tw", ":Twilight<CR>", { desc = "toggle twilight" }),
}
