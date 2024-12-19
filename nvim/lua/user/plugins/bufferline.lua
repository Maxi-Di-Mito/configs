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

    --- @type bufferline.UserConfig
    bufferline.setup({
      options = {
        mode = "buffers",
        separator_style = "thin",
        indicator = {
          style = "underline",
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
        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
        --   return "(" .. count .. ")"
        -- end,
      },
      -- highlights = require("catppuccin.groups.integrations.bufferline").get(),
      -- highlights = require("rose-pine.plugins.bufferline"),
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
  end,
}
