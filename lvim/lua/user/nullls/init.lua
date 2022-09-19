local linters = require "lvim.lsp.null-ls.linters"

linters.setup {
  {
    command = "eslint_d",
    filetypes = {
      "javascript",
      "javascriptreact",
      -- "svelte",
      "typescript",
      "typescriptreact",
    },
  },
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    command = "eslint_d",
    args = { "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" },
    -- args = { "--json" },
    filetypes = {
      "javascript",
      "javascriptreact",
      -- "svelte",
      "typescript",
      "typescriptreact",
    },
  },
}

require("lspconfig").tsserver.setup({
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(client)
    client.server_capabilities.document_formatting          = false
    client.server_capabilities.documentFormattingProvider   = false
    client.resolved_capabilities.document_formatting        = false
    client.resolved_capabilities.documentFormattingProvider = false
  end,
})

local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup {
  {
    command = "eslint_d",
    args = { "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
  },
  -- {
  --   command = "prettier",
  --   filetypes = {
  --     "javascript",
  --     "javascriptreact",
  --     "typescript",
  --     "typescriptreact",
  --   }
  -- }
}
