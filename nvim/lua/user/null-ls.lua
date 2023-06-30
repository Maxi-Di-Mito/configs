local ok, null = pcall(require, "null-ls")

if not ok then
	return
end

-- find . -iname '*.jpg'

-- NO WORK, DISABLED to ALWAYS TRUE, check later
local function hasRootEslintConfig(utils)
	--[[ local result2 = exists(".eslintrc*") ]]
	local result = utils.root_has_file({
		".eslinrc.json",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.yaml",
		".eslintrc.yml",
	})
	return result
end

local sources = {
	null.builtins.diagnostics.golangci_lint.with({
		diagnostic_config = {
			virtual_text = true,
		},
		extra_args = { "--fix", "true" },
	}),
	null.builtins.diagnostics.eslint.with({
		condition = hasRootEslintConfig,
		diagnostic_config = {
			virtual_text = true,
		},
		disabled_filetypes = { "svelte" },
		filetypes = { "vue" },
	}),
	null.builtins.code_actions.eslint.with({
		condition = hasRootEslintConfig,
		filetypes = { "vue" },
	}),
	null.builtins.formatting.eslint.with({
		condition = hasRootEslintConfig,
		filetypes = { "vue" },
	}),
	null.builtins.diagnostics.eslint_d.with({
		diagnostic_config = {
			virtual_text = true,
		},
		disabled_filetypes = { "svelte", "vue" },
	}),
	null.builtins.formatting.eslint_d.with({
		disabled_filetypes = { "svelte", "vue" },
	}),
	null.builtins.code_actions.eslint_d.with({
		disabled_filetypes = { "svelte", "vue" },
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

function FormattingFunction(doAsync)
	doAsync = doAsync or false
	vim.lsp.buf.format({
		async = doAsync,
		timeout_ms = 4000,
		filter = function()
			return true
		end,
	})
end
