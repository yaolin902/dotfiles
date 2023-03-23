local status_ok, treesitter = pcall(require, "nvim-treesitter")
if not status_ok then
	return
end

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

local status_ok, context = pcall(require, "treesitter-context")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = {
		"lua",
		"markdown",
		"markdown_inline",
		"bash",
		"python",
		"c",
		"cpp",
		"vim",
		"regex",
		"typescript",
		"svelte",
		"html",
		"css",
		"javascript",
		"tsx",
	},
	ignore_install = { "" },
	sync_install = false,

	highlight = {
		enable = true,
		disable = { "css" },
	},
	autopairs = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css", "ymal" } },

	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" },
		extended_mode = true,
		max_file_lines = nil,
	},
})

context.setup({
	enable = true,
	max_lines = 0,
	trim_scope = "outer",
	min_window_height = 0,
	patterns = {
		default = {
			"class",
			"function",
			"method",
			"for",
			"while",
			"if",
			"switch",
			"case",
			"interface",
			"struct",
			"enum",
		},
		tex = {
			"chapter",
			"section",
			"subsection",
			"subsubsection",
		},
		haskell = {
			"adt",
		},
		rust = {
			"impl_item",
		},
		terraform = {
			"block",
			"object_elem",
			"attribute",
		},
		scala = {
			"object_definition",
		},
		vhdl = {
			"process_statement",
			"architecture_body",
			"entity_declaration",
		},
		markdown = {
			"section",
		},
		elixir = {
			"anonymous_function",
			"arguments",
			"block",
			"do_block",
			"list",
			"map",
			"tuple",
			"quoted_content",
		},
		json = {
			"pair",
		},
		typescript = {
			"export_statement",
		},
		yaml = {
			"block_mapping_pair",
		},
	},
	exact_patterns = {},

	zindex = 20,
	mode = "cursor",
	separator = nil,
})
