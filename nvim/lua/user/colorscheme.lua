local tokyo = require("tokyonight")
tokyo.setup({
	dim_inactive = true,
})

local ok = pcall(vim.cmd, "colorscheme tokyonight-moon")
if not ok then
	print("there was a problem loading the colorscheme")
end
