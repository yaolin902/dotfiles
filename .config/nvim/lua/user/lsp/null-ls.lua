local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	-- on_init = function(new_client, _)
	-- 	new_client.offset_encoding = "utf-8"
	-- end,
	debug = false,
	sources = {
		formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		formatting.csharpier.with({ extra_args = { "--fast" } }),
		formatting.sqlfluff,
		formatting.shfmt,
		diagnostics.flake8,
		diagnostics.eslint,
		diagnostics.cpplint,
	},
})
