return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			stages = "slide",
			timeout = 1500,
			background_colour = "#000000",
			enabled = false,
		})
		vim.notify = require("notify")
	end,
}
