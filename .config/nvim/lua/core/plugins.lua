-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
	-- Package manager
	use({ "wbthomason/packer.nvim" })

	use({ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"RRethy/vim-illuminate",
			"j-hui/fidget.nvim",
			"folke/neodev.nvim",
		},
	})

	use({ "jose-elias-alvarez/null-ls.nvim" })

	-- Autocompletion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path", -- path completions
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip", -- snippet completions

			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets", -- a bunch of snippets to use
		},
	})

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	})

	-- Git related plugins
	use({
		"tpope/vim-fugitive",
		cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
		requires = {
			"tpope/vim-rhubarb",
		},
	})

	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- Colorschemes
	use({ "navarasu/onedark.nvim" })
	use({ "folke/tokyonight.nvim" })
	use({ "sainnhe/gruvbox-material" })
	use({ "lunarvim/darkplus.nvim" })
	use({ "kyazdani42/nvim-palenight.lua" })

	-- Statusline
	use({ "nvim-lualine/lualine.nvim" })

	-- Add indentation guides even on blank lines
	use({ "lukas-reineke/indent-blankline.nvim" })

	-- "gc" to comment visual regions/lines
	use({ "numToStr/Comment.nvim" })

	use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically
	-- use 'theprimeagen/harpoon'

	use({ "mbbill/undotree" })

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "kyazdani42/nvim-web-devicons" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
		},
	})

	use({ "akinsho/toggleterm.nvim" })

	-- Autopairs, integrates with both cmp and treesitter
	use({
		"windwp/nvim-autopairs",
	})

	use({ "ahmedkhalf/project.nvim" })

	-- Tmux & split window navigation
	use({ "christoomey/vim-tmux-navigator" })

	use({ "vimwiki/vimwiki" })

	-- install without yarn or npm
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	if is_bootstrap then
		require("packer").sync()
	end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
	return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerCompile",
	group = packer_group,
	pattern = vim.fn.expand("$MYVIMRC"),
})

-- vim: ts=2 sts=2 sw=2 et
