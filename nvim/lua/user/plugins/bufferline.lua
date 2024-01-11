return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },

  config = function()
    local ok, bufferline = pcall(require, "bufferline")

    if not ok then
      return
    end

    bufferline.setup({
      options = {
        separator_style = "slant",
      },
      -- highlights = require("catppuccin.groups.integrations.bufferline").get(),
      -- highlights = require("rose-pine.plugins.bufferline"),
    })
  end,
}
