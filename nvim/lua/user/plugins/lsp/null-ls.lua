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
	-- null.builtins.diagnostics.golangci_lint.with({
	--   diagnostic_config = {
	--     virtual_text = true,
	--   },
	--   extra_args = { "--fix", "true" },
	-- }),
	--[[ null.builtins.diagnostics.eslint.with({ ]]
	--[[ 	condition = hasRootEslintConfig, ]]
	--[[ 	diagnostic_config = { ]]
	--[[ 		virtual_text = true, ]]
	--[[ 	}, ]]
	--[[ 	disabled_filetypes = { "svelte" }, ]]
	--[[ 	filetypes = { "vue" }, ]]
	--[[ 	diagnostics_format = "#{m} [#{c}]", ]]
	--[[ }), ]]
	--[[ null.builtins.code_actions.eslint.with({ ]]
	--[[ 	condition = hasRootEslintConfig, ]]
	--[[ 	filetypes = { "vue" }, ]]
	--[[ }), ]]
	--[[ null.builtins.formatting.eslint.with({ ]]
	--[[ 	condition = hasRootEslintConfig, ]]
	--[[ 	filetypes = { "vue" }, ]]
	--[[ }), ]]
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
		disabled_filetypes = { "svelte" },
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
