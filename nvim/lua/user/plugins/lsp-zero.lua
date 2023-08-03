local lsp = require("lsp-zero")

-- Recommended preset
lsp.preset({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = true,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = "local",
  sign_icons = {
    error = "✘",
    warn = "▲",
    hint = "⚑",
    info = "",
  },
})
lsp.nvim_workspace()

-- CMP custom config
--[[ local cmpConfig = require("cmp") ]]

--[[ local mergedConfig = lsp.defaults.cmp_config(cmpConfig) ]]

--[[ lsp.setup_nvim_cmp(mergedConfig) ]]

local okNavic, navic = pcall(require, "nvim-navic")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

lsp.on_attach(function(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_exec(
      [[
    augroup lsp_document_highlight
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END

  ]],
      false
    )
  end

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    group = augroup,
    callback = function()
      FormattingFunction()
    end,
  })

  if client.server_capabilities.documentSymbolProvider and okNavic then
    navic.attach(client, bufnr)
  end
end)

lsp.configure("volar", {
  settings = {
    volar = {
      format = {
        initialIndent = {
          html = true,
          javascript = true,
          typescript = true,
          css = true,
          scss = true,
        },
      },
    },
  },
})

lsp.configure("tsserver", {
  settings = {
    diagnostics = {
      ignoredCodes = { 7016, 80001 }, -- 7016 types , 80001 this could be a module bleh,
    },
  },
})

lsp.setup()
