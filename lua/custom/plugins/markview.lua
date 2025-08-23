-- For `plugins/markview.lua` users.

return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	priority = 49,
	config = function()
		local presets = require("markview.presets")
		local headings = presets.headings
		local horizontal_rules = presets.horizontal_rules

		require("markview").setup({
			markdown = {
				headings = headings.marker,
				horizontal_rules = horizontal_rules.dashed,
			},
		})
	end,
}
