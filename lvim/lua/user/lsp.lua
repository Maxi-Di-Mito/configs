--
-- Activate LunarVim tailwindcss lsp configuration only
-- if project seems to have a tailwindcss dependency
--
-- local utils = require "user.utils"
-- local project_has_tailwindcss_dependency = function()
--   return (vim.fn.glob "tailwind*" ~= "" or utils.is_in_package_json "tailwindcss")
-- end

-- if project_has_tailwindcss_dependency() == true then
--   require("lvim.lsp.manager").setup "tailwindcss"
-- end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- SNIPPET CAPABILITY
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- ESLINT
-- local eslint = require 'lspconfig'.eslint
-- if eslint then
--   eslint.setup {
--     filetypes = {
--       "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"
--     },
--     eslint_enable_diagnostics = true,
--   }
--   vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
--     command = 'EslintFixAll'
--   })
-- end


-- CSS
require 'lspconfig'.cssls.setup {
  capabilities = capabilities,
}

-- JSON

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
