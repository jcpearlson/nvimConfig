-- config loading and settings for tree file explorer

return {
	"nvim-tree/nvim-tree.lua",
	--	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			renderer = {
				icons = {
					glyphs = {
						default = "-", -- Default file
						symlink = "~", -- Symlink
						folder = {
							arrow_closed = ">", -- Closed folder arrow
							arrow_open = "v", -- Open folder arrow
							default = "+", -- Folder
							open = "-", -- Open folder
							empty = "+", -- Empty folder
							empty_open = "-", -- Open empty folder
							symlink = "~", -- Symlinked folder
							symlink_open = "~", -- Open symlinked folder
						},
						git = {
							unstaged = "!",
							staged = "+",
							unmerged = "=",
							renamed = "→",
							untracked = "?",
							deleted = "-",
							ignored = "·",
						},
					},
				},
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
	end,
}
