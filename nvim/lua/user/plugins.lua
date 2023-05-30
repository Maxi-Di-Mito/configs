local fn = vim.fn

-- Automatically install packer
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
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	-- Packer puede actualizarse solo
	use("wbthomason/packer.nvim")

	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("JoosepAlviste/nvim-ts-context-commentstring")

	use("jiangmiao/auto-pairs")
	use("lukas-reineke/indent-blankline.nvim")

	use({
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	})

	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	use("gpanders/editorconfig.nvim")

	use("nvim-lua/plenary.nvim")
	-- Themes
	use("folke/tokyonight.nvim")
	use("EdenEast/nightfox.nvim")
	use("ellisonleao/gruvbox.nvim")

	-- LSP
	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- Soporte LSP
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletado
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	use("jose-elias-alvarez/null-ls.nvim")

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("p00f/nvim-ts-rainbow")

	use("nvim-treesitter/nvim-treesitter-context")

	use("norcalli/nvim-colorizer.lua")

	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icons
		},
	})
	use({
		"windwp/nvim-ts-autotag",
		requires = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-ts-autotag").setup({ enable = true })
		end,
	})
	--fix cursorhold autocmds with LSP (check if updating neovim fixes)
	--[[ use("antoinemadec/FixCursorHold.nvim") ]]
	use("tpope/vim-surround")

	use("alexghergh/nvim-tmux-navigation")
	-- Git
	use("lewis6991/gitsigns.nvim")
	use("b0o/schemastore.nvim")

	use("akinsho/bufferline.nvim")

	use("folke/which-key.nvim")

	-- fzf
	use({
		"ibhagwan/fzf-lua",
		-- optional for icon support
		requires = { "nvim-tree/nvim-web-devicons" },
	})
	use({ "junegunn/fzf", dir = "~/.fzf", run = "./install --all" })

	use({
		"mfussenegger/nvim-dap",
		opt = true,
		module = { "dap" },
		requires = {
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
			--[[ "mfussenegger/nvim-dap-python", ]]
			--[[ "nvim-telescope/telescope-dap.nvim", ]]
			--[[ { "leoluz/nvim-dap-go", module = "dap-go" }, ]]
			--[[ { "jbyuki/one-small-step-for-vimkind", module = "osv" }, ]]
			{ "mxsdev/nvim-dap-vscode-js" },
			{
				"microsoft/vscode-js-debug",
				opt = true,
				run = "npm install --legacy-peer-deps && npm run compile",
			},
		},
		disable = false,
	})
	-- Debugging
	--[[ use({ ]]
	--[[ 	"mfussenegger/nvim-dap", ]]
	--[[ 	opt = true, ]]
	--[[ 	event = "BufReadPre", ]]
	--[[ 	module = { "dap" }, ]]
	--[[ 	wants = { "nvim-dap-virtual-text", "nvim-dap-ui", "nvim-dap-python", "which-key.nvim" }, ]]
	--[[ 	requires = { ]]
	--[[ 		"theHamsta/nvim-dap-virtual-text", ]]
	--[[ 		"rcarriga/nvim-dap-ui", ]]
	--[[ 		"nvim-telescope/telescope-dap.nvim", ]]
	--[[ 		{ "jbyuki/one-small-step-for-vimkind", module = "osv" }, ]]
	--[[ 	}, ]]
	--[[ }) ]]
end)
