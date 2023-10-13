return {
  "akinsho/bufferline.nvim",
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
    })
  end,
}
