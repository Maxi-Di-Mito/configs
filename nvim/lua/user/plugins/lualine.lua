return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = LualineTheme,
        component_separators = "",
        section_separators = "",
        globalstatus = true,
        disabled_filetypes = { "packer", "NvimTree" },
        refresh = {
          statusline = 300,
        },
      },
      filetype_names = {
        TelescopePrompt = "Telescope",
        dashboard = "Dashboard",
        packer = "Packer",
        fzf = "FZF",
        alpha = "Alpha",
      },
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
      },
      --[[ tabline = { ]]
      --[[ 	lualine_a = { ]]
      --[[ 		{ "buffers", symbols = { alternate_file = "" } }, ]]
      --[[ 	}, ]]
      --[[ }, ]]
      winbar = {
        lualine_b = {
          { "filename", path = 4 },
        },
      },
      inactive_winbar = {
        lualine_c = { { "filename", path = 4 } },
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
      -- tabline = {
      --   lualine_y = {
      --     "tabs",
      --   },
      --   lualine_z = {
      --     "buffers",
      --   },
      -- },
    })
  end,
}
