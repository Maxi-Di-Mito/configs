return {
  { -- Optional
    "mason-org/mason.nvim",
    event = "VeryLazy",
    dependencies = {
      { "jayp0521/mason-null-ls.nvim" },
      { "nvimtools/none-ls.nvim" },
      { "mason-org/mason-lspconfig.nvim" },
      { "gbprod/none-ls-luacheck.nvim" },
    },
    config = function()
      -- import mason plugin safely
      local mason = require("mason")

      local mason_lspconfig = require("mason-lspconfig")

      -- import mason-null-ls plugin safely
      local mason_null_ls = require("mason-null-ls")

      -- enable mason
      mason.setup()

      mason_lspconfig.setup({
        -- list of servers for mason to install
        ensure_installed = {
          "bashls",
          "ts_ls",
          -- "eslint",
          "html",
          "cssls",
          "lua_ls",
          "vue_ls@2.2.8",
          "gopls",
          "bashls",
          "jsonls",
          "dockerls",
          "taplo",
          "yamlls",
        },
        -- auto-install configured servers (with lspconfig)
        automatic_installation = true, -- not the same as ensure_installed
      })

      mason_null_ls.setup({
        -- list of formatters & linters for mason to install
        ensure_installed = {
          "prettier", -- ts/js formatter
          "stylua", -- lua formatter
          "golangci_lint",
          "luacheck",

          -- "eslint_d", -- ts/js linter
        },
        -- auto-install configured formatters & linters (with null-ls)
        automatic_installation = true,
      })
    end,
  },
}
