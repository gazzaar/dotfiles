return {
	"folke/noice.nvim",
	event = "VeryLazy",
	config = function()
		require("noice").setup({
			-- for clean pop up
			views = {
				cmdline_popup = {
					border = {
						style = "none",
						padding = { 1, 1 },
					},
					filter_options = {},
					win_options = {
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
					},
				},
			},
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
			-- lsp = {
			-- 	-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			-- 	override = {
			-- 		["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			-- 		["vim.lsp.util.stylize_markdown"] = true,
			-- 		["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			-- 	},
			-- },
			lsp = {
				hover = {
					enabled = false,
				},
				signature = {
					enabled = false, -- Disable Noice's signatureHelp handling
				},
			},
			messages = {
				enabled = true,
				view = "mini", -- You can also try 'split' or 'notify' for different styles
				view_error = "notify", -- Use the notify view for errors
				view_warn = "mini", -- Use the mini view for warnings
			},
			routes = {
				-- for @recording messages
				-- {
				-- 	view = "mini",
				-- 	filter = { event = "msg_showmode" },
				-- },

				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
							{ find = "%d fewer lines" },
							{ find = "%d more lines" },
						},
					},
					opts = { skip = true },
				},
			},
		})
	end,

	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}
