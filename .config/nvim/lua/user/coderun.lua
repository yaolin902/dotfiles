local status_ok, coderun = pcall(require, "code_runner")
if not status_ok then
	return
end

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

coderun.setup({
  mode = "toggleterm",
  
  -- for competitive programmming
  -- filetype = {
  --   python = "clear; make run $fileNameWithoutExt -s",
  --   cpp = "clear; make run $fileNameWithoutExt -s",
  -- },
})

keymap('n', '<leader>r', ':RunCode<CR>', opts)
