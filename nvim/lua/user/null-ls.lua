local ok, null = pcall(require, "null-ls")

if not ok then
	return
end
-- NO WORK, DISABLED to ALWAYS TRUE, check later
local function hasRootEslintConfig(utils)
	local result = utils.root_has_file({
		".eslinrc.json",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.yaml",
		".eslintrc.yml",
	})
	return true or result
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
	}),
	null.builtins.code_actions.eslint.with({
		condition = hasRootEslintConfig,
	}),
	null.builtins.formatting.eslint.with({
		condition = hasRootEslintConfig,
	}),
	null.builtins.formatting.prettier.with({
		filetypes = { "json", "markdown", "html", "yaml", "css", "scss", "less" },
	}),
	null.builtins.formatting.stylua,
	null.builtins.formatting.gofmt,
}

null.setup({
	sources = sources,
})
