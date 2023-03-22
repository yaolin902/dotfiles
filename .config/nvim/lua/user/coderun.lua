local status_ok, coderun = pcall(require, "code_runner")
if not status_ok then
	return
end

coderun.setup({
	mode = "toggleterm",
	-- for competitive programmming
	-- filetype = {
	--   python = "clear; make run $fileNameWithoutExt -s",
	--   cpp = "clear; make run $fileNameWithoutExt -s",
	-- },
})
