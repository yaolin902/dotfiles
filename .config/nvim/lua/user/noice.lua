local status_ok, noice = pcall(require, "noice")
if not status_ok then
	return
end

noice.setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
		signature = { enabled = false },
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = false,
	},
	routes = {
		{
			filter = {
				any = {
					{ find = "multiple different client offset_encodings" },
					{ find = "open_on_setup behaviour has been deprecated" },
				},
			},
			opts = { skip = true },
		},
	},
})

vim.cmd([[
highlight NoiceCmdlinePopupBorder guibg=#282828 guifg=#83A598 gui=nocombine
highlight NoiceCmdlineIcon guibg=#282828 guifg=#83A598 gui=nocombine
]])
