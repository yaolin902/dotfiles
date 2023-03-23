local status_ok, dashboard = pcall(require, "dashboard")
if not status_ok then
	return
end

dashboard.setup({
	theme = "hyper",
	config = {
		week_header = {
			enable = false,
		},
		shortcut = {
			-- { desc = " Update", group = "@property", action = "Lazy update", key = "u" },
			{
				icon = " ",
				desc = "Find file",
				group = "Variable",
				action = "Telescope find_files",
				key = "f",
			},
			{
				icon = " ",
				desc = "New file",
				group = "String",
				action = "ene <BAR> startinsert",
				key = "e",
			},
			{
				icon = " ",
				desc = "Find project",
				group = "Boolean",
				action = "lua require('telescope').extensions.projects.projects()",
				key = "p",
			},
			{
				icon = " ",
				desc = "Find text",
				group = "Macro",
				action = "Telescope live_grep",
				key = "t",
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
