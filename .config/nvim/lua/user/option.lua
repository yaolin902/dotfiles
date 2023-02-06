local opt = vim.opt

opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.completeopt = "menuone,noinsert,noselect"

opt.number = true
opt.showmatch = true
opt.foldmethod = "marker"
opt.colorcolumn = "80"
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.conceallevel = 0
opt.cmdheight = 1
opt.fileencoding = "utf-8"
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
-- opt.signcolumn = 'number'
opt.showmode = false

opt.number = true
opt.relativenumber = true
opt.shortmess:append("c")
opt.whichwrap:append("<,>,[,],h,l")
opt.iskeyword:append("-")
opt.formatoptions:remove({ "c", "r", "o" })
opt.fillchars.eob = " "
opt.pumheight = 10
opt.undofile = true
opt.cursorline = true
opt.updatetime = 300

opt.background = "dark"
vim.api.nvim_set_hl(0, 'htmlArg', { italic=true })
vim.cmd([[colorscheme gruvbox]])
vim.api.nvim_set_hl(0, 'htmlArg', { italic=true })
-- vim.api.nvim_set_hl(0, 'xmlAttrib', { italic=true })
