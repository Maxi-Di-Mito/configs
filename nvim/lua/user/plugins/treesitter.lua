return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
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

    vim.treesitter.language.register("html", "gohtmltmpl") --

    require("treesitter-context").setup()
  end,
}
