local servers = {
	"lua_ls",
	"pyright",
	"jsonls",
	"clangd",
  "omnisharp",
  "sqlls",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end

-- -- omnisharp
-- local nvim_lsp = require("lspconfig")
--
-- local pid = vim.fn.getpid()
-- -- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
-- local omnisharp_bin = "/home/y41/.local/share/nvim/mason/packages/omnisharp-mono/run"
--
-- nvim_lsp.omnisharp.setup({
-- 	cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
-- 	root_dir = nvim_lsp.util.root_pattern("*.csproj", "*.sln"),
-- 	on_attach = require("user.lsp.handlers").on_attach,
-- 	capabilities = require("user.lsp.handlers").capabilities,
-- })
