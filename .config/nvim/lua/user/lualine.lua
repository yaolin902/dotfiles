local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = {
		error = " ",
		warn = " ",
	},
	colored = true,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = " ", modified = " ", removed = " " },
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local filetype = {
	"filetype",
	colored = true,
	icons_enabled = true,
	icon = { align = "left" },
}

local function list_registered_providers_names(filetype)
	local s = require("null-ls.sources")
	local available_sources = s.get_available(filetype)
	local registered = {}
	for _, source in ipairs(available_sources) do
		for method in pairs(source.methods) do
			registered[method] = registered[method] or {}
			table.insert(registered[method], source.name)
		end
	end
	return registered
end

local function list_registered_formatter(filetype)
	local method = null_ls.methods.FORMATTING
	local registered_providers = list_registered_providers_names(filetype)
	return registered_providers[method] or {}
end

local function list_registered_linter(filetype)
	local alternative_methods = {
		null_ls.methods.DIAGNOSTICS,
		null_ls.methods.DIAGNOSTICS_ON_OPEN,
		null_ls.methods.DIAGNOSTICS_ON_SAVE,
	}
	local registered_providers = list_registered_providers_names(filetype)
	local providers_for_methods = vim.tbl_flatten(vim.tbl_map(function(m)
		return registered_providers[m] or {}
	end, alternative_methods))

	return providers_for_methods
end

local lsp = {
	function(msg)
		msg = msg or "LS Inactive"
		local buf_clients = vim.lsp.buf_get_clients()
		if next(buf_clients) == nil then
			if type(msg) == "boolean" or #msg == 0 then
				return "LS Inactive"
			end
			return msg
		end
		local buf_ft = vim.bo.filetype
		local buf_client_names = {}

		-- add client
		-- for _, client in pairs(buf_clients) do
		-- 	if client.name ~= "null-ls" and client.name ~= "copilot" then
		-- 		table.insert(buf_client_names, client.name)
		-- 	end
		-- end

		-- add formatter
		local supported_formatters = list_registered_formatter(buf_ft)
		vim.list_extend(buf_client_names, supported_formatters)

		-- add linter
		local supported_linters = list_registered_linter(buf_ft)
		vim.list_extend(buf_client_names, supported_linters)

		local unique_client_names = vim.fn.uniq(buf_client_names)

		local language_servers = table.concat(unique_client_names, " ")

		return language_servers
	end,
	icon = { "", align = "left" },
}

local filename = {
	"filename",
	file_status = false,
	newfile_statue = false,
	path = 3,
	cond = hide_in_width,
	shorting_target = 300,
}

local fileformat = {
	"fileformat",
	symbols = {
		unix = "",
		dos = "",
		mac = "",
	},
	separator = "",
	padding = { left = 1, right = -1 },
	cond = hide_in_width,
}

local location = {
	"location",
	icon = { "", align = "left" },
}

local encoding = {
	"encoding",
	cond = hide_in_width,
}

lualine.setup({
	options = {
		theme = "gruvbox",
		icons_enabled = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { branch },
		lualine_c = { diagnostics, filename, lsp },
		lualine_x = { diff, fileformat, encoding, filetype },
		lualine_y = { location },
		lualine_z = { "progress" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { filename },
		lualine_x = { location },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
