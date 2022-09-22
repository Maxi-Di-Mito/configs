-- cursor diagnostics
vim.api.nvim_create_autocmd({ 'CursorHold' },
  { pattern = "*", command = 'lua vim.lsp.diagnostic.show_position_diagnostics()' })
--
--[[ vim.api.nvim_create_autocmd({ 'CursorHoldI' }, { pattern = "*", command = 'lua vim.lsp.buf.signature_help()' }) ]]
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { focus = false }
)

-- format on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = "*", command = "LspZeroFormat!" })


-- hightlight on YANK
vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  command = "silent! lua vim.highlight.on_yank()",
  group = "highlight_yank"
})
