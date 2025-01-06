-- NOTE: this will overwrite the existing s command in nvim
-- also note that the existing one is crappy anyway
return {
	"gbprod/substitute.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local substitute = require("substitute")

		substitute.setup()

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		vim.keymap.set("n", "s", substitute.operator, { desc = "Substitute with motion" })
		vim.keymap.set("n", "ss", substitute.line, { desc = "Substitute line" })
		vim.keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line" })
		vim.keymap.set("x", "s", substitute.visual, { desc = "Substitute in visual mode" })
	end,
}
