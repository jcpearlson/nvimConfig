-- This file will contain alpha.lua package and manage my home screen for vim
return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Function to check the operating system
		local function OS()
			local os = package.config:sub(1, 1)
			if os == "\\" then
				return "win"
			elseif os == "/" then
				return "unix"
			else
				return "unknown"
			end
		end

		-- Check if the OS is Windows
		local is_windows = OS() == "win"

		-- Define variables for dynamic time and working directory
		local date_line = "  " .. os.date("%Y-%m-%d")
		local time_line = "  " .. os.date("%I:%M:%S %p")
		local cwd_line = "  " .. vim.fn.getcwd()

		-- NOTE: these are os specific so we have to check if we are on windows or unix
		if is_windows then
			battery_line = "  plugged in :)"
		else
			battery_line = "  " .. vim.fn.system("acpi | awk '{print $4}'"):gsub(",", ""):gsub("\n", "")
		end

		-- TODO: implement showing the current github branch here
		local git_branch = vim.fn.system("git branch --show-current"):gsub("\n", "")
		local branch_line = git_branch ~= "" and ("  " .. git_branch) or "  Not in a Git repo"
		branch_line = " "

		-- Function to refresh the time
		local function update_time()
			time_line = "  " .. os.date("%I:%M:%S %p")
			alpha.redraw()
		end

		-- Set up a timer to update the time every minute
		local timer = vim.loop.new_timer()
		timer:start(0, 1000, vim.schedule_wrap(update_time)) -- Update every 60 seconds

		-- Set header
		dashboard.section.header.val = {
			"	          ██╗ ██████╗ ███████╗██╗  ██╗██╗   ██╗██╗███╗   ███╗		",
			"	          ██║██╔═══██╗██╔════╝██║  ██║██║   ██║██║████╗ ████║		",
			"	          ██║██║   ██║███████╗███████║██║   ██║██║██╔████╔██║		",
			"	     ██   ██║██║   ██║╚════██║██╔══██║╚██╗ ██╔╝██║██║╚██╔╝██║		",
			"	     ╚█████╔╝╚██████╔╝███████║██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║		",
			"	      ╚════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝		",
		}

		-- Add date, time, and working directory below the header
		dashboard.section.footer.val = function()
			return {
				date_line,
				time_line,
				cwd_line,
				battery_line,
				branch_line,
			}
		end

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
			dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("SPC ff", "  > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("SPC wr", "  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
			dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
