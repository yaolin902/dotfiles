local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
	return
end

saga.setup({
	ui = {
		title = false,
		border = "rounded",
		winblend = 0,
		expand = "",
		collapse = "",
		code_action = "",
		incoming = " ",
		outgoing = " ",
		hover = " ",
		kind = {},
	},
	border_style = "rounded",
	symbol_in_winbar = {
		enable = true,
		separator = " > ",
		ignore_patterns = {},
		hide_keyword = true,
		show_file = true,
		folder_level = 2,
		respect_root = false,
		color_mode = true,
	},
})

vim.cmd([[
highlight LspSignatureActiveParameter guibg=#665c54 gui=nocombine
]])
