local ok, null = pcall(require, "null-ls")

if not ok then
	return
end

local sources = {
	null.builtins.diagnostics.eslint_d.with({
		condition = function(utils)
			return true
				or utils.root_has_file({
					".eslinrc.json",
					".eslintrc.js",
					".eslintrc.cjs",
					".eslintrc.yaml",
					".eslintrc.yml",
				})
		end,
		diagnostic_config = {
			virtual_text = true,
		},
		disabled_filetypes = { "svelte", "vue" },
	}),
	null.builtins.code_actions.eslint_d,
	null.builtins.formatting.eslint_d,
	null.builtins.formatting.prettier.with({
		filetypes = { "json", "markdown", "html", "yaml", "css", "scss", "less" },
	}),
	null.builtins.formatting.stylua,
}

null.setup({
	sources = sources,
})
