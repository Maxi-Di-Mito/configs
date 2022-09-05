--
-- Activate LunarVim tailwindcss lsp configuration only
-- if project seems to have a tailwindcss dependency
--
local utils = require "user.utils"
local project_has_tailwindcss_dependency = function()
  return (vim.fn.glob "tailwind*" ~= "" or utils.is_in_package_json "tailwindcss")
end

if project_has_tailwindcss_dependency() == true then
  require("lvim.lsp.manager").setup "tailwindcss"
end

-- ESLINT
local eslint = require 'lspconfig'.eslint
if eslint then
  eslint.setup {
    filetypes = {
      "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"
    }
  }
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
    command = 'EslintFixAll'
  })
end

-- SNIPPET CAPABILITY
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- CSS
capabilities.textDocument.completion.completionItem.snippetSupport = true

require 'lspconfig'.cssls.setup {
  capabilities = capabilities,
}

-- JSON
capabilities.textDocument.completion.completionItem.snippetSupport = true

require 'lspconfig'.jsonls.setup {
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}

-- HTML
require 'lspconfig'.html.setup {
  capabilities = capabilities,
}
