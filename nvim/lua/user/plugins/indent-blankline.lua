return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  enabled = vim.env.TERMUX_VERSION == nil,
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    indent = { char = "┊" },
    scope = {
      char = "┊",
      enabled = true,
      show_start = true,
    },
  },
}
