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

local options = {
  install = {
    -- colorscheme = { "nightfly" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
}

require("lazy").setup({
  { import = "user.plugins" },
  { import = "user.plugins.lsp" },
  "numToStr/Comment.nvim",
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup()
    end,
  },
  -- Themes
  --[[ "folke/tokyonight.nvim", ]]
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   priority = 1000,
  --   config = function()
  --     require("user.plugins.colorscheme")
  --   end,
  -- },
  -- LSP Support

  -- Autocompletion
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("nvim-ts-autotag").setup({ enable = true })
    end,
  },
  "tpope/vim-surround",
  -- Git
  "b0o/schemastore.nvim",
}, options)
