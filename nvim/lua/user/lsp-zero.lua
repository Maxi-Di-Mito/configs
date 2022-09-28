local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.nvim_workspace();

lsp.setup();


-- CMP custom config
local cmpConfig = require('user.cmp')

local mergedConfig = lsp.defaults.cmp_config(cmpConfig)

local cmp = require 'cmp'
cmp.setup(mergedConfig)


lsp.on_attach(function(client, bufnr)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    augroup lsp_document_highlight
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END

  ]] , false)
  end
end)
