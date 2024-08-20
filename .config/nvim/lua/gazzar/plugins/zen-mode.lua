return {
	"folke/zen-mode.nvim",
	opts = {
		plugins = {
			tmux = { enabled = true },
		},
		on_open = function(_)
			vim.fn.system("tmux set status off")
		end,
		on_close = function()
			vim.fn.system("tmux set status on")
		end,
	},
	config = function(_, opts)
		require("zen-mode").setup(opts)
		vim.keymap.set("n", "<leader>z", function()
			require("zen-mode").toggle()
		end, { noremap = true, silent = true })
	end,
}
