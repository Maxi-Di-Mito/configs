return {
  "nvimtools/none-ls.nvim",
  -- priority = 999,
  dependencies = {
    "mason-org/mason.nvim",
  },
  enabled = true,
  config = function()
    local ok, null = pcall(require, "null-ls")

    if not ok then
      return
    end

    local sources = {
      null.builtins.formatting.prettier.with({
        filetypes = { "json", "markdown", "html", "yaml", "css", "scss", "less" },
      }),
      null.builtins.formatting.stylua,
      null.builtins.formatting.gofmt,
      null.builtins.diagnostics.golangci_lint.with({
        extra_args = { "--disable errcheck" },
      }),
      require("none-ls-luacheck.diagnostics.luacheck").with({
        extra_args = { "--global vim" },
      }),
      -- null.builtins.diagnostics.luacheck.with({
      --   extra_args = { "--global vim" },
      -- }),
    }

    null.setup({
      sources = sources,
    })

    function FormattingFunction(doAsync, timeout)
      doAsync = doAsync or false
      timeout = timeout or 15000
      pcall(function()
        vim.cmd("EslintFixAll")
      end)
      pcall(function()
        vim.lsp.buf.format({
          async = doAsync,
          silently = true,
          timeout_ms = timeout,
          filter = function()
            return true
          end,
        })
      end)
    end
  end,
}
