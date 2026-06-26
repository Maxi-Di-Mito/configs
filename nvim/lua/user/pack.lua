local github = "https://github.com/"

-- Helper for GitHub repos
local function gh(repo)
  return github .. repo
end

vim.pack.add({
  -- Colorschemes
  { src = gh("catppuccin/nvim"),             name = "catppuccin" },
  { src = gh("sainnhe/everforest"),          name = "everforest" },
  { src = gh("rose-pine/neovim"),            name = "rose-pine" },
  { src = gh("EdenEast/nightfox.nvim"),      name = "nightfox" },
  { src = gh("folke/tokyonight.nvim"),       name = "tokyonight" },

  -- UI
  { src = gh("nvim-lualine/lualine.nvim"),   name = "lualine" },
  { src = gh("akinsho/bufferline.nvim"),     name = "bufferline" },
  { src = gh("nvim-neo-tree/neo-tree.nvim"), name = "neo-tree",    version = "v3.x" },
  { src = gh("nvim-tree/nvim-web-devicons"), name = "nvim-web-devicons" },
  { src = gh("lukas-reineke/indent-blankline.nvim"), name = "indent-blankline" },
  { src = gh("NvChad/nvim-colorizer.lua"),  name = "colorizer" },
  { src = gh("folke/which-key.nvim"),        name = "which-key" },

  -- Completion
  { src = gh("saghen/blink.cmp"),            name = "blink.cmp" },
  { src = gh("saghen/blink.lib"),            name = "blink.lib" },
  { src = gh("fang2hou/blink-copilot"),       name = "blink-copilot" },
  { src = gh("zbirenbaum/copilot.lua"),      name = "copilot" },
  { src = gh("folke/lazydev.nvim"),          name = "lazydev" },
  { src = gh("rafamadriz/friendly-snippets"), name = "friendly-snippets" },

  -- LSP / Tooling
  { src = gh("neovim/nvim-lspconfig"),  name = "nvim-lspconfig" },
  { src = gh("mason-org/mason.nvim"),        name = "mason" },
  { src = gh("mason-org/mason-lspconfig.nvim"), name = "mason-lspconfig" },

  -- Formatting
  { src = gh("stevearc/conform.nvim"),       name = "conform" },

  -- Treesitter
  { src = gh("nvim-treesitter/nvim-treesitter"), name = "treesitter" },
  { src = gh("nvim-treesitter/nvim-treesitter-context"), name = "treesitter-context" },
  { src = gh("JoosepAlviste/nvim-ts-context-commentstring"), name = "ts-context-commentstring" },
  { src = gh("windwp/nvim-ts-autotag"),      name = "ts-autotag" },

  -- Editing
  { src = gh("windwp/nvim-autopairs"),       name = "nvim-autopairs" },
  { src = gh("tpope/vim-surround"),          name = "vim-surround" },
  { src = gh("echasnovski/mini.comment"),    name = "mini-comment" },

  -- Navigation
  { src = gh("ibhagwan/fzf-lua"),            name = "fzf-lua" },
  { src = gh("junegunn/fzf"),                name = "fzf",          build = "./install --all" },
  { src = gh("smoka7/hop.nvim"),             name = "hop" },
  { src = gh("alexghergh/nvim-tmux-navigation"), name = "tmux-navigator" },

  -- Git
  { src = gh("lewis6991/gitsigns.nvim"),     name = "gitsigns" },

  -- Misc
  { src = gh("b0o/schemastore.nvim"),        name = "schemastore" },
  { src = gh("heilgar/nvim-http-client"),    name = "rest-nvim" },
  { src = gh("nvimdev/guard.nvim"),          name = "guard" },

  -- Dependencies
  { src = gh("nvim-lua/plenary.nvim"),       name = "plenary" },
  { src = gh("MunifTanjim/nui.nvim"),        name = "nui" },
})

-- Configure plugins that need more than empty .setup()
require("user.plugins.colorscheme")
require("user.plugins.bufferline")
require("user.plugins.fzf-lua")
require("user.plugins.gitsigns")
require("user.plugins.lualine")
require("user.plugins.neo-tree")
require("user.plugins.rest-nvim")
require("user.plugins.tmux-navigator")
require("user.plugins.treesitter")
require("user.plugins.blink")
require("user.plugins.conform")
require("user.plugins.hop")
require("user.plugins.lsp.mason")
require("user.plugins.lsp.lsp-config")

-- Simple plugins: setup with opts or no config
require("which-key").setup()
require("nvim-autopairs").setup()
require("nvim-ts-autotag").setup({ enable = true })
require("mini.comment").setup({
  options = {
    custom_commentstring = function()
      return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
    end,
  },
})
require("ibl").setup()
require("colorizer").setup()
require("nvim-web-devicons").setup()
