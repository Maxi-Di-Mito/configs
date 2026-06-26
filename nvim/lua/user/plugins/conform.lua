require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofmt" },
    json = { "prettier" },
    markdown = { "prettier" },
    html = { "prettier" },
    yaml = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    less = { "prettier" },
    sh = { "shfmt" },
    bash = { "shfmt" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

vim.keymap.set("n", "<leader>lf", function()
  pcall(vim.cmd, "LspEslintFixAll")
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format" })
