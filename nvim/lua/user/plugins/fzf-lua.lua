return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  event = "VeryLazy",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
    { "junegunn/fzf", build = "./install --all" },
  },
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup({
      lsp = {
        cwd_only = true,
      },
    })
    -- Fix to scroll on fzf popup
    vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-j> <Down>]])
    vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-k> <Up>]])
    vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-h> <nop>]])
    vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-l> <nop>]])

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    local wk = require("which-key")
    wk.add({
      { "<leader>g", group = "Git" },
    })

    wk.add({
      { "<leader>s", group = "Search" },
    })

    wk.add({
      { "g", group = "Go To's" },
    })

    keymap.set("n", "gd", "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", { desc = "Definition" })
    keymap.set("n", "gr", "<cmd>lua require('fzf-lua').lsp_references()<CR>", { desc = "References" })
    keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Line Diagnostics" })

    keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>", { desc = "Find files" })
    keymap.set("n", "<leader>bf", "<cmd>FzfLua buffers<cr>", { desc = "Find current buffers" })
    keymap.set("n", "<leader>gC", "<cmd>FzfLua git_commits<cr>", { desc = "Checkout commit(workspace)" })
    keymap.set("n", "<leader>gc", "<cmd>FzfLua git_bcommits<cr>", { desc = "Find buffer's commits" })
    keymap.set("n", "<leader>go", "<cmd>FzfLua git_status<cr>", { desc = "Git status files" })
    keymap.set("n", "<leader>gb ", "<cmd>lua require('fzf-lua').git_branches()<cr>", { desc = "Checkout branch" })
    keymap.set("n", "<leader>st", "<cmd>FzfLua live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>ss", "<cmd>lua require('fzf-lua').blines()<cr>", { desc = "Text in Buffer" })

    keymap.set("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "File symbols" })
    keymap.set("n", "<leader>lS", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", { desc = "Document Symbols" })
    keymap.set("n", "<leader>lD", "<cmd>FzfLua lsp_workspace_diagnostics<cr>", { desc = "Workspace Diagnostics" })
  end,
}
