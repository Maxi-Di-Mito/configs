local ok, null = pcall(require, "null-ls")

if not ok then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local sources = {
  null.builtins.diagnostics.eslint_d.with {
    diagnostic_config = {
      virtual_text = true
    },
  },
  null.builtins.formatting.eslint_d,
  null.builtins.formatting.stylua,
}




null.setup {
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          vim.lsp.buf.formatting_seq_sync()
        end,
      })
    end
  end,
}
