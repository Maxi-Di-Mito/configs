return {
  "jose-elias-alvarez/null-ls.nvim",
  -- priority = 999,
  config = function()
    local ok, null = pcall(require, "null-ls")

    if not ok then
      return
    end

    -- find . -iname '*.jpg'

    -- NO WORK, DISABLED to ALWAYS TRUE, check later
    local function hasRootEslintConfig(utils)
      --[[ local result2 = exists(".eslintrc*") ]]
      local result = utils.root_has_file({
        ".eslintrc.json",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.yaml",
        ".eslintrc.yml",
      })
      return result
    end

    local sources = {
      -- null.builtins.diagnostics.eslint.with({
      --   condition = hasRootEslintConfig,
      --   diagnostic_config = {
      --     virtual_text = true,
      --   },
      --   diagnostics_format = "#{m} [#{c}]",
      --   filetypes = { "vue" },
      -- }),
      null.builtins.formatting.eslint.with({
        condition = hasRootEslintConfig,
        filetypes = { "vue" },
      }),
      -- null.builtins.code_actions.eslint.with({
      --   condition = hasRootEslintConfig,
      --   filetypes = { "vue" },
      -- }),
      null.builtins.diagnostics.eslint_d.with({
        condition = hasRootEslintConfig,
        diagnostic_config = {
          virtual_text = true,
        },
        diagnostics_format = "#{m} [#{c}]",
        disabled_filetypes = { "svelte" },
      }),
      null.builtins.formatting.eslint_d.with({
        condition = hasRootEslintConfig,
        disabled_filetypes = { "svelte", "vue" },
      }),
      null.builtins.code_actions.eslint_d.with({
        condition = hasRootEslintConfig,
        disabled_filetypes = { "svelte" },
      }),

      null.builtins.formatting.prettier.with({
        filetypes = { "json", "markdown", "html", "yaml", "css", "scss", "less" },
      }),
      null.builtins.formatting.stylua,
      null.builtins.formatting.gofmt,
      null.builtins.formatting.rustfmt,
      null.builtins.diagnostics.luacheck.with({
        extra_args = { "--global vim" },
      }),
    }

    null.setup({
      sources = sources,
    })

    --[[ local clientsToDilter = { ]]
    --[[   'prettier' ]]
    --[[ } ]]

    function FormattingFunction(doAsync, timeout)
      doAsync = doAsync or false
      timeout = timeout or 6000
      vim.lsp.buf.format({
        async = doAsync,
        timeout_ms = timeout,
        filter = function()
          return true
        end,
      })

      -- doesn work, check later
      if not doAsync then
        local current_line = vim.fn.line("$")
        local last_line = vim.fn.getline(current_line)

        if not vim.fn.empty(last_line) then
          vim.cmd("a")
          vim.cmd("normal! o")
          -- vim.fn.append(current_line, "") -- Append an empty line
          vim.cmd("w")
        end
      end
    end
  end,
}
