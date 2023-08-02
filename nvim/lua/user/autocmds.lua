-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	group = augroup,
-- 	callback = function()
-- 		FormattingFunction()
-- 	end,
-- })

-- hightlight on YANK
-- vim.api.nvim_create_augroup("highlight_yank", { clear = true })
-- vim.api.nvim_create_autocmd({ "TextYankPost" }, {
--   command = "silent! lua vim.highlight.on_yank()",
--   group = "highlight_yank",
-- })

--[[ vim.api.nvim_create_augroup("gitsignsFixAttach", { clear = true }) ]]
--[[ vim.api.nvim_create_autocmd({ "BufNew" }, { ]]
--[[ 	command = "Gitsigns attach", ]]
--[[ 	group = "gitsignsFixAttach", ]]
--[[ }) ]]
