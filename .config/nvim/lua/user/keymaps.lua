local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap
local keymaps = vim.keymap.set

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

keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

keymaps("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
keymaps({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
keymaps("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
keymaps("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
keymaps("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymaps("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
keymaps("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymaps("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymaps("n", "[E", function()
	require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, opts)
keymaps("n", "]E", function()
	require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, opts)
keymaps("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

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
