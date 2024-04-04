return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local setup = {
      plugins = {
        marks = false, -- shows a list of your marks on ' and `
        registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = false, -- adds help for operators like d, y, ...
          motions = false, -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = false, -- default bindings on <c-w>
          nav = false, -- misc bindings to work with windows
          z = false, -- bindings for folds, spelling and others prefixed with z
          g = false, -- bindings for prefixed with g
        },
        spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },
      popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
      },
      window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
      },
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
      ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
      show_help = true, -- show help message on the command line when the popup is visible
      triggers = "auto", -- automatically setup triggers
      -- triggers = {"<leader>"} -- or specify a list manually
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
      },
    }

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
      [";"] = { "<cmd>Alpha<CR>", "Dashboard" },
      ["w"] = { "<cmd>w!<CR>", "Save" },
      ["q"] = { "<cmd>q<cr>", "Quit" },
      ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },

      -- ["f"] = {
      --   "<cmd>lua require('fzf-lua').files({cmd ='ag --hidden --ignore .git --path-to-ignore ~/configs/.ignore -g \"\"'})<cr>",
      --   "Find File",
      -- },
      ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
      b = {
        name = "Buffers",
        b = { "<cmd>b#<cr>", "Back" },
        j = { "<cmd>BufferLinePick<cr>", "Jump" },
        -- f = { "<cmd>lua require('fzf-lua').buffers()<cr>", "Find" },
        -- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
        e = {
          "<cmd>BufferLinePickClose<cr>",
          "Pick which buffer to close",
        },
        h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
        l = {
          "<cmd>BufferLineCloseRight<cr>",
          "Close all to the right",
        },
      },
      e = {
        "<cmd>Neotree toggle<cr>",
        "File tree",
      },
      g = {
        name = "Git",
      },
      l = {
        name = "LSP",
      },
      s = {
        name = "Search",
      },
      T = {
        name = "Treesitter",
        i = { ":TSConfigInfo<cr>", "Info" },
      },
    }

    local which_key = require("which-key")

    which_key.setup(setup)

    which_key.register(mappings, opts)
    which_key.register(normalMappings, normalOpts)
    which_key.register(vmappings, vopts)
  end,
}
