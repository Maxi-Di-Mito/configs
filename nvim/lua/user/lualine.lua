require("lualine").setup({
	options = {
		theme = "tokyonight",
		globalstatus = true,
		disabled_filetypes = { "packer", "NvimTree" },
		refresh = {
			statusline = 300,
		},
	},
	sections = {
		lualine_c = {
			{
				"filename",
				path = 1,
			},
		},
	},
	winbar = {
		lualine_c = { { "filename", path = 1 } },
	},
	inactive_winbar = {
		lualine_c = { { "filename", path = 1 } },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			{
				"filename",
				path = 1,
			},
		},
		lualine_x = { "filetype", "location" },
		lualine_y = {},
		lualine_z = {},
	},
})
