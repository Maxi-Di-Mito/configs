local utils = require("user.utils")
return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  enabled = not utils.isTermux(),
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
