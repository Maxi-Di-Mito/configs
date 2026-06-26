local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup()

mason_lspconfig.setup({
  ensure_installed = {
    "bashls",
    "ts_ls",
    "html",
    "cssls",
    "lua_ls",
    "vue_ls@2.2.8",
    "gopls",
    "jsonls",
    "dockerls",
    "taplo",
    "yamlls",
  },
  automatic_installation = true,
})
