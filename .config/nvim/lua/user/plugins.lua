local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("installing packer.nvim")
	vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use({ "wbthomason/packer.nvim" })
	use({ "nvim-lua/popup.nvim" })
	use({ "nvim-lua/plenary.nvim" })

	-- colorschemes
	use({ "ellisonleao/gruvbox.nvim" })

	-- ui
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	use({ "akinsho/bufferline.nvim" })
	use({ "lewis6991/gitsigns.nvim" })
	use({ "kyazdani42/nvim-tree.lua" })
	use({ "akinsho/toggleterm.nvim" })
	use({ "glepnir/dashboard-nvim" })
	use({ "folke/noice.nvim", requires = "MunifTanjim/nui.nvim" })
	use({ "rcarriga/nvim-notify" })
	use({ "lukas-reineke/indent-blankline.nvim" })
	use({ "kevinhwang91/nvim-hlslens" })

	-- utilities
	use({ "famiu/bufdelete.nvim" })
	use({ "barklan/capslock.nvim" })
	use({ "ahmedkhalf/project.nvim" })
	use({ "lewis6991/impatient.nvim" })
	use({ "mbbill/undotree" })
	use({ "kevinhwang91/nvim-ufo", requires = { "kevinhwang91/promise-async", "luukvbaal/statuscol.nvim" } })
	use({ "folke/which-key.nvim" })
	use({ "sindrets/diffview.nvim" })
	use({ "CRAG666/code_runner.nvim" })
	use({ "numToStr/Comment.nvim" })
	use({ "metakirby5/codi.vim" })
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	-- quality of life
	use({ "beauwilliams/focus.nvim" })
	use({ "windwp/nvim-autopairs" })
	use({ "phaazon/hop.nvim" })
	use({ "AckslD/nvim-neoclip.lua" })
	use({ "ggandor/flit.nvim", requires = "ggandor/leap.nvim" })
	use({ "folke/todo-comments.nvim" })
	use({ "MattesGroeger/vim-bookmarks" })
	use({ "kylechui/nvim-surround" })
	use({ "NvChad/nvim-colorizer.lua" })
	use({ "karb94/neoscroll.nvim" })

	-- completion
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-calc" })
	use({ "f3fora/cmp-spell" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "L3MON4D3/LuaSnip" })
	use({ "rafamadriz/friendly-snippets" })
	use({ "jcdickinson/codeium.nvim" })

	-- LSP
	use({ "neovim/nvim-lspconfig" })
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "onsails/lspkind.nvim" })
	use({ "RRethy/vim-illuminate" })
	use({ "glepnir/lspsaga.nvim" })
	use({ "ray-x/lsp_signature.nvim" })
	use({ "folke/trouble.nvim" })

	-- telescope
	use({ "nvim-telescope/telescope.nvim" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "kdheepak/lazygit.nvim" })

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use({ "nvim-treesitter/playground" })
	use({ "p00f/nvim-ts-rainbow" })
	use({ "windwp/nvim-ts-autotag" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	use({ "nvim-treesitter/nvim-treesitter-context" })

	-- DAP
	use({ "mfussenegger/nvim-dap" })
	use({ "rcarriga/nvim-dap-ui" })
	use({ "ravenxrz/DAPInstall.nvim" })

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
