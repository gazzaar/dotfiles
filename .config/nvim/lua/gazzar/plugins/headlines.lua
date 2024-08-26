return {
	"lukas-reineke/headlines.nvim",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		local headlines = require("headlines")
		headlines.setup({
			markdown = {
				headline_highlights = false,
			},
			org = {
				query = vim.treesitter.query.parse(
					"org",
					[[
				            (headline (stars) @headline)

				            (
				                (expr) @dash
				                (#match? @dash "^-----+$")
				            )

				            (block
				                name: (expr) @_name
				                (#match? @_name "(SRC|src)")
				            ) @codeblock

				            (paragraph . (expr) @quote
				                (#eq? @quote ">")
				            )
				        ]]
				),
				-- headline_highlights = { "Headline" },
				headline_highlights = false,
				bullet_highlights = {
					"@org.headline.level1",
					"@org.headline.level2",
					"@org.headline.level3",
					"@org.headline.level4",
					"@org.headline.level5",
					"@org.headline.level6",
					"@org.headline.level7",
					"@org.headline.level8",
				},
				bullets = { "◉", "○", "✸", "✿" },
				codeblock_highlight = "CodeBlock",
				dash_highlight = "Dash",
				dash_string = "-",
				quote_highlight = "Quote",
				quote_string = "┃",
				fat_headlines = true,
				fat_headline_upper_string = "▃",
				fat_headline_lower_string = "🬂",
			},
		})
	end,
}
