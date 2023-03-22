local status_ok, focus = pcall(require, "focus")
if not status_ok then
	return
end

focus.setup()

local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
	return
end

colorizer.setup()

local status_ok, todo = pcall(require, "todo-comments")
if not status_ok then
	return
end

todo.setup()

local status_ok, hop = pcall(require, "hop")
if not status_ok then
	return
end

hop.setup({ keys = "etovxqpdygfblzhckisuran" })

local status_ok, neoclip = pcall(require, "neoclip")
if not status_ok then
	return
end

neoclip.setup()

local status_ok, flit = pcall(require, "flit")
if not status_ok then
	return
end

flit.setup({
	keys = { f = "f", F = "F", t = "t", T = "T" },
	labeled_modes = "v",
	multiline = true,
	opts = {},
})

local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
	return
end

trouble.setup()

local status_ok, surround = pcall(require, "nvim-surround")
if not status_ok then
	return
end

surround.setup()

local status_ok, codeium = pcall(require, "codeium")
if not status_ok then
	return
end

codeium.setup()

vim.cmd([[
highlight CodiVirtualText cterm=italic gui=italic guifg=#928374
let g:codi#interpreters = {
\ 'cpp' : {
\ 'bin' : 'cling',
\ 'prompt' : '^\[cling\]\$ ',
\ },
\ }
]])
