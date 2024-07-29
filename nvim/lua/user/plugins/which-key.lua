return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local normalOpts = {
      mode = "n",
      silent = true,
      noremap = true,
    }

    local normalMappings = {
      g = {
        name = "Go To's",
        d = { "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", "Definition" },
        r = { "<cmd>lua require('fzf-lua').lsp_references()<CR>", "References" },
        l = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },
      },
    }

    local opts = {
      mode = "n", -- NORMAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    }
    local vopts = {
      mode = "v", -- VISUAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    }
    -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
    -- see https://neovim.io/doc/user/map.html#:map-cmd
    local vmappings = {
      ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
    }
    local mappings = {
      s = {
        name = "Search",
      },
      T = {
        name = "Treesitter",
        i = { ":TSConfigInfo<cr>", "Info" },
      },
    }

    local which_key = require("which-key")

    which_key.setup()

    which_key.register(mappings, opts)
    which_key.register(normalMappings, normalOpts)
    which_key.register(vmappings, vopts)
  end,
}
