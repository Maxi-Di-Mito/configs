local setup = {
  plugins = {
    marks = false,   -- shows a list of your marks on ' and `
    registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false,                           -- adds help for operators like d, y, ...
      motions = false,                             -- adds help for motions
      text_objects = false,                        -- help for text objects triggered after entering an operator
      windows = false,                             -- default bindings on <c-w>
      nav = false,                                 -- misc bindings to work with windows
      z = false,                                   -- bindings for folds, spelling and others prefixed with z
      g = false,                                   -- bindings for prefixed with g
    },
    spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+",    -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "single",      -- none, single, double, shadow
    position = "bottom",    -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },                                            -- min and max height of the columns
    width = { min = 20, max = 50 },                                            -- min and max width of the columns
    spacing = 3,                                                               -- spacing between columns
    align = "left",                                                            -- align columns left, center or right
  },
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  ignore_missing = false,                                                      -- enable this to hide mappings for which you didn't specify a label
  show_help = true,                                                            -- show help message on the command line when the popup is visible
  triggers = "auto",                                                           -- automatically setup triggers
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
  mode = "n",    -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,  -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local vopts = {
  mode = "v",    -- VISUAL mode
  prefix = "<leader>",
  buffer = nil,  -- Global mappings. Specify a buffer number for buffer local mappings
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
  ["c"] = { "<cmd>BufferKill<CR>", "Close Buffer" },

  ["f"] = {
    "<cmd>lua require('fzf-lua').files({cmd ='ag --hidden --ignore .git --path-to-ignore ~/configs/.ignore -g \"\"'})<cr>",
    "Find File",
  },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  b = {
    name = "Buffers",
    b = { "<cmd>b#<cr>", "Back" },
    j = { "<cmd>BufferLinePick<cr>", "Jump" },
    f = { "<cmd>lua require('fzf-lua').buffers()<cr>", "Find" },
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
    "<cmd>NvimTreeToggle<cr>",
    "Nvim Tree",
  },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  -- " Available Debug Adapters:
  -- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
  -- " Adapter configuration and installation instructions:
  -- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
  -- " Debug Adapter protocol:
  -- "   https://microsoft.github.io/debug-adapter-protocol/
  -- " Debugging
  g = {
    name = "Git",
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>lua require('fzf-lua').git_status()<cr>", "Open changed file" },
    b = { "<cmd>lua require('fzf-lua').git_branches()<cr>", "Checkout branch" },
    c = { "<cmd>lua require('fzf-lua').git_bcommits()<cr>", "Checkout commit" },
    C = {
      "<cmd>lua require('fzf-lua').git_commits()<cr>",
      "Checkout commit(workspace)",
    },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Git Diff",
    },
  },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>lua require('fzf-lua').lsp_document_diagnostics()<cr>", "Buffer Diagnostics" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Diagnostics" },
    f = { "<cmd>lua FormattingFunction(true)<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>Mason<cr>", "Mason Info" },
    K = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
    j = {
      vim.diagnostic.goto_next,
      "Next Diagnostic",
    },
    k = {
      vim.diagnostic.goto_prev,
      "Prev Diagnostic",
    },
    l = { vim.lsp.codelens.run, "CodeLens Action" },
    q = { vim.diagnostic.setloclist, "Quickfix" },
    r = { vim.lsp.buf.rename, "Rename" },
    s = { "<cmd>lua require('fzf-lua').lsp_document_symbols()<cr>", "Document Symbols" },
    S = {
      "<cmd>lua require('fzf-lua').lsp_workspace_symbols()<cr>",
      "Workspace Symbols",
    },
    v = {
      function()
        vim.diagnostic.show(nil, 0, nil, { virtual_text = false })
        print("virtualText off")
      end,
      "Virtual text off",
    },
    V = {
      function()
        vim.diagnostic.show(nil, 0, nil, { virtual_text = true })
        print("virtualText on")
      end,
      "Virtual text on",
    },
    e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
  },
  s = {
    name = "Search",
    f = { "<cmd>lua require('fzf-lua').files()<cr>", "Find File" },
    M = { "<cmd>lua require('fzf-lua').man_pages()<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    t = { "<cmd>lua require('fzf-lua').live_grep()<cr>", "Text" },
    s = { "<cmd>lua require('fzf-lua').blines()<cr>", "Text in Buffer" },
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
