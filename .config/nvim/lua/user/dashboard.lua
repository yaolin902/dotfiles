local status_ok, dashboard = pcall(require, "dashboard")
if not status_ok then
	return
end

dashboard.setup({
	theme = "hyper",
	config = {
		week_header = {
			enable = true,
		},
		shortcut = {
			-- { desc = " Update", group = "@property", action = "Lazy update", key = "u" },
			{
				icon = " ",
				icon_hl = "@variable",
				desc = "Find file",
				group = "Label",
				action = "Telescope find_files",
				key = "f",
			},
			{
				icon = " ",
				desc = "New file",
				group = "Label",
				action = "ene <BAR> startinsert",
				key = "e",
			},
			{
				icon = " ",
				desc = "Find project",
				group = "Label",
				action = "lua require('telescope').extensions.projects.projects()",
				key = "p",
			},
			{
				icon = " ",
				desc = "Find text",
				group = "Label",
				action = "Telescope live_grep",
				key = "t",
			},
			{
				icon = " ",
				desc = "Config",
				group = "Label",
				action = "e $MYVIMRC",
				key = "c",
			},
			{
				icon = " ",
				desc = "Quit",
				group = "Label",
				action = "qa",
				key = "q",
			},
		},
	},
})
