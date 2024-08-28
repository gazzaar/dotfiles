return {
	"folke/zen-mode.nvim",
	opts = {
		plugins = {
			tmux = { enabled = true },
		},
	},
	config = function(_, opts)
		require("zen-mode").setup(opts)
		vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", { desc = "toggle zen mode" })
	end,
}
