return {
  "nvimdev/guard.nvim",
  enabled = false,
  dependencies = {
    "nvimdev/guard-collection",
    "mason-org/mason.nvim",
  },
  config = function()
    vim.g.guard_config = {
      -- format on write to buffer
      fmt_on_save = true,
      -- use lsp if no formatter was defined for this filetype
      lsp_as_default_formatter = true,
      -- whether or not to save the buffer after formatting
      save_on_fmt = true,
      -- automatic linting
      auto_lint = true,
      -- how frequently can linters be called
      lint_interval = 1000,
      -- show diagnostic after format done
      refresh_diagnostic = true,
    }
    local ft = require("guard.filetype")

    ft("javascript,typescript,vue"):fmt("lsp"):append({
      cmd = "npx",
      args = { "eslint_d", "--fix"},
      fname = true,
     stdin = true,
    }):lint("eslint_d")

    ft("lua"):fmt("lsp"):append("stylua"):lint("luacheck", {
      args = { "--std", "luajit", "--global", "vim" },
    })

    ft("go"):fmt("lsp"):append("gofmt"):lint("golangci_lint", {
      args = { "--disable", "errcheck" },
    })

    ft("json,markdown,html,yaml,css,scss,less"):fmt("lsp"):append("prettier")
  end,
}
