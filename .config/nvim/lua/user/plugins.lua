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
	use({ "ellisonleao/gruvbox.nvim" })
	-- use { "almo7aya/neogruvbox.nvim" }
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	use({ "akinsho/bufferline.nvim" })
	use({ "moll/vim-bbye" })
	use({ "barklan/capslock.nvim" })
	use({ "lewis6991/gitsigns.nvim" })
	use({ "dinhhuy258/git.nvim" })
	use({ "kyazdani42/nvim-tree.lua" })
	use({ "akinsho/toggleterm.nvim" })
	use({ "ahmedkhalf/project.nvim" })
	use({ "lewis6991/impatient.nvim" })
	use({ "lukas-reineke/indent-blankline.nvim" })
	use({ "goolord/alpha-nvim" })
	use({ "mbbill/undotree" })
	use({ "kevinhwang91/nvim-ufo", requires = { "kevinhwang91/promise-async", "luukvbaal/statuscol.nvim" } })
	-- use({ "folke/which-key.nvim" })
	use({ "sindrets/diffview.nvim" })
	-- use({ "gelguy/wilder.nvim" })
	use({ "karb94/neoscroll.nvim" })
	use({ "ThePrimeagen/harpoon" })
	use({ "folke/todo-comments.nvim" })
	use({ "MattesGroeger/vim-bookmarks" })
	use({ "kevinhwang91/rnvimr" })
	use({ "beauwilliams/focus.nvim" })
	use({ "NvChad/nvim-colorizer.lua" })
	use({ "phaazon/hop.nvim" })
	use({ "AckslD/nvim-neoclip.lua" })
	use({ "folke/noice.nvim", requires = "MunifTanjim/nui.nvim" })
	use({ "ggandor/flit.nvim", requires = "ggandor/leap.nvim" })

	-- completion
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "saadparwaiz1/cmp_luasnip" })

	use({ "L3MON4D3/LuaSnip" })
	use({ "rafamadriz/friendly-snippets" })
	use({ "windwp/nvim-autopairs" })
	use({ "numToStr/Comment.nvim" })
	use({ "metakirby5/codi.vim" })

	-- LSP
	use({ "neovim/nvim-lspconfig" })
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "rcarriga/nvim-notify" })

	use({ "simrat39/symbols-outline.nvim" })
	-- use({ "SmiteshP/nvim-navic" })
	use({ "RRethy/vim-illuminate" })
	use({ "glepnir/lspsaga.nvim" })
	use({ "CRAG666/code_runner.nvim" })
	use({ "kevinhwang91/nvim-hlslens" })
	-- use({ "liuchengxu/vista.vim" })
	use({ "ray-x/lsp_signature.nvim" })
	use({ "folke/trouble.nvim" })

	-- telescope
	use({ "nvim-telescope/telescope.nvim" })
	use({ "nvim-telescope/telescope-media-files.nvim" })
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

	-- markdown pv
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
