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
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
    vim.lsp.buf.formatting_seq_sync()
  end,
})


-- hightlight on YANK
vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  command = "silent! lua vim.highlight.on_yank()",
  group = "highlight_yank"
})
