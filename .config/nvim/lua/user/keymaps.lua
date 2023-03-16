local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)
keymap("n", "<leader>tf", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>tg", ":Telescope live_grep<cr>", opts)
-- keymap("n", "<leader>s", ":SymbolsOutline<cr>", opts)
keymap("n", "<leader>u", ":UndotreeToggle<cr>", opts)
keymap("n", "<leader>j", ":HopWord<cr>", opts)
-- keymap("n", "<leader>r", ":RnvimrToggle<cr>", opts)
keymap("n", "<leader>c", ":Codi!!<cr>", opts)
keymap("n", "<leader>g", ":LazyGit<cr>", opts)
keymap("n", "<leader>xx", ":TroubleToggle<cr>", opts)
keymap("n", "<leader>ll", ":ToggleDiag<cr>", opts)

keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

local status_ok, capslock = pcall(require, "capslock")
if not status_ok then
	return
end

capslock.setup()
keymap("i", "<C-l>", "<Plug>CapsLockToggle", opts)

vim.g.diagnostics_active = true
function _G.toggle_diagnostics()
	if vim.g.diagnostics_active then
		vim.g.diagnostics_active = false
		vim.cmd([[LspStop]])
	else
		vim.g.diagnostics_active = true
		vim.cmd([[LspStart]])
	end
end
keymap("n", "<leader>ll", ":call v:lua.toggle_diagnostics()<CR>", opts)
