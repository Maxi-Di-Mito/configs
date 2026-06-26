local utils = require("user.utils")

require("bufferline").setup({
  options = {
    mode = "buffers",
    separator_style = "thin",
    indicator = {
      style = utils.isTermux() and "underline" or "icon",
    },
    diagnostics = "nvim_lsp",
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        text_align = "left",
        separator = true,
      },
    },
  },
})

local wk = require("which-key")

wk.add({
  { "<leader>b", group = "Buffers" },
})

local keymap = vim.keymap

keymap.set("n", "<leader>bj", "<cmd>BufferLinePick<cr>", { desc = "Jump" })
keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseRight<cr>", { desc = "Close all to the right" })
keymap.set("n", "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close all to the left" })
keymap.set("n", "<leader>be", "<cmd>BufferLinePickClose<cr>", { desc = "Pick which buffer to close" })
