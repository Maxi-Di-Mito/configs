require('packer').startup(function(use)
  -- Packer puede actualizarse solo
  use 'wbthomason/packer.nvim'

  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
  }

  use 'jiangmiao/auto-pairs'
  use 'APZelos/blamer.nvim'
  use 'vim-scripts/indentLine.vim'
  use 'camspiers/animate.vim'
  use 'camspiers/lens.vim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }


  use 'gpanders/editorconfig.nvim'

  use {
    'gfanto/fzf-lsp.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  -- Tema
  use 'joshdick/onedark.vim'
  use 'morhetz/gruvbox'
  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- Soporte LSP
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/nvim-lsp-installer' },

      -- Autocompletado
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use 'airblade/vim-gitgutter'

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
  }

  use { 'kevinhwang91/nvim-bqf', ft = 'qf' }
  -- fzf
  use { 'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
  use { 'junegunn/fzf.vim' }
end)
