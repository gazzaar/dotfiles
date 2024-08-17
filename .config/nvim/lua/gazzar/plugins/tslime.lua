return {
	"jpalardy/vim-slime",
	config = function()
		vim.g.slime_target = "tmux"
		vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }
		vim.keymap.set("x", "\\t", "<Plug>SlimeRegionSend", { silent = true })
		vim.keymap.set("n", "\\t", "<Plug>SlimeLineSend", { silent = true })
		vim.keymap.set("n", "\\T", "<Plug>SlimeConfig", { silent = true })
	end,
}
