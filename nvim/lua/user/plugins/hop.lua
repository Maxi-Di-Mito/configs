return {
  "smoka7/hop.nvim",
  version = "*",
  event = "VeryLazy",
  config = function()
    local hop = require("hop")

    hop.setup({})

    vim.keymap.set("n", "<leader>sj", "<cmd>HopChar2<cr>", { desc = "Jump to any two characters" })
  end,
}
