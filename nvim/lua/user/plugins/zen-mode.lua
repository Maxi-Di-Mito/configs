return {
  "folke/zen-mode.nvim",
  config = function()
    require("zen-mode").setup({
      window = {
        backdrop = 0.7,
        width = 0.7,
      },
    })

    vim.keymap.set("n", "<leader>z", ":ZenMode<cr>", { desc = "Toggle Zen Mode", silent = true })
  end,
}
