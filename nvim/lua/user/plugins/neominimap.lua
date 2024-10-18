return {
  "Isrothy/neominimap.nvim",
  version = "v3.*.*",
  enabled = true,
  event = { "BufReadPre", "BufNewFile" },
  -- Optional
  keys = {
    -- Global Minimap Controls
  },
  config = function()
    -- The following options are recommended when layout == "float"
    vim.opt.wrap = false
    vim.opt.sidescrolloff = 36 -- Set a large value

    --- Put your configuration here
    vim.g.neominimap = {
      auto_enable = true,
    }

    local neominimap = require("neominimap")

    neominimap.setup()

    local wk = require("which-key")

    wk.add({
      { "<leader>m", group = "Map" },
    })

    vim.keymap.set("n", "<leader>mt", "<cmd>Neominimap toggle<cr>", { desc = "Toggle global minimap" })
    vim.keymap.set("n", "<leader>me", "<cmd>Neominimap on<cr>", { desc = "Enable global minimap" })
    vim.keymap.set("n", "<leader>md", "<cmd>Neominimap off<cr>", { desc = "Disable global minimap" })
    vim.keymap.set("n", "<leader>mr", "<cmd>Neominimap refresh<cr>", { desc = "Refresh global minimap" })
    vim.keymap.set("n", "<leader>mm", "<cmd>Neominimap toggleFocus<cr>", { desc = "Switch focus on minimap" })

    -- Refresh all windows in current tab when focus switched

    vim.api.nvim_create_autocmd("WinEnter", {
      group = vim.api.nvim_create_augroup("minimap", { clear = true }),
      pattern = "*",
      callback = function()
        require("neominimap").tabRefresh({}, {})
      end,
    })

    vim.g.neominimap = {
      layout = "float",
      win_filter = function(winid)
        return winid == vim.api.nvim_get_current_win()
      end,
    }
  end,
}
