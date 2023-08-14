local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local options = {}

require("lazy").setup({
	"numToStr/Comment.nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",
	--[[ "lukas-reineke/indent-blankline.nvim", ]]
	{
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},
	{
		"SmiteshP/nvim-navic",
		dependencies = "neovim/nvim-lspconfig",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("user.plugins.lualine")
		end,
	},
	-- "gpanders/editorconfig.nvim",
	"nvim-lua/plenary.nvim",
	-- Themes
	--[[ "folke/tokyonight.nvim", ]]
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		config = function()
			require("user.plugins.colorscheme")
		end,
	},
	-- {
	--   "ellisonleao/gruvbox.nvim",
	--   priority = 1000,
	--   config = function()
	--     require("user.plugins.colorscheme")
	--   end,
	-- },
	-- LSP Support
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("user.plugins.lsp.lsp-config")
		end,
	}, -- Required
	{ -- Optional
		"williamboman/mason.nvim",
		config = function()
			require("user.plugins.lsp.mason")
		end,
		dependencies = {
			{ "williamboman/mason-lspconfig.nvim" },
			{ "jayp0521/mason-null-ls.nvim" },
		},
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("user.plugins.cmp")
		end,
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
			-- Icons
			{ "onsails/lspkind-nvim" },
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		-- priority = 999,
		config = function()
			require("user.plugins.lsp.null-ls")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
		},
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "lua", "vim", "vimdoc", "query", "typescript", "javascript", "html" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true, disable = { "yaml" } },
				autopairs = {
					enable = true,
				},
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
			})
			require("treesitter-context").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				"*",
			}, {
				mode = "background",
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				names = true,
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		config = function()
			require("user.plugins.neo-tree")
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-ts-autotag").setup({ enable = true })
		end,
	},
	"tpope/vim-surround",
	{
		"alexghergh/nvim-tmux-navigation",
		config = function()
			local nvim_tmux_nav = require("nvim-tmux-navigation")
			nvim_tmux_nav.setup({
				disable_when_zoomed = true, -- defaults to false
			})
			vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
			vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
			vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
			vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
			vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
			vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
		end,
	},
	-- Git
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("user.plugins.gitsigns")
		end,
	},
	"b0o/schemastore.nvim",

	{
		"akinsho/bufferline.nvim",
		config = function()
			require("user.plugins.bufferline")
		end,
	},

	{
		"folke/which-key.nvim",
		config = function()
			require("user.plugins.which-key")
		end,
	},
	--[[ "onsails/lspkind-nvim", ]]
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			local fzf = require("fzf-lua")
			fzf.setup({})
			-- Fix to scroll on fzf popup
			vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-j> <Down>]])
			vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-k> <Up>]])
			vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-h> <nop>]])
			vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-l> <nop>]])
		end,
	},

	{ "junegunn/fzf", build = "./install --all" },
}, options)
