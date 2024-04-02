return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "kyazdani42/nvim-web-devicons",
    { "junegunn/fzf", build = "./install --all" },
  },
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup({})
    -- Fix to scroll on fzf popup
    vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-j> <Down>]])
    vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-k> <Up>]])
    vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-h> <nop>]])
    vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-l> <nop>]])

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>", { desc = "Find files" })
    keymap.set("n", "<leader>st", "<cmd>FzfLua live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>bf", "<cmd>FzfLua buffers<cr>", { desc = "Find current buffers" })
    keymap.set("n", "<leader>gc", "<cmd>FzfLua git_bcommits<cr>", { desc = "Find buffer's commits" })
    keymap.set("n", "<leader>go", "<cmd>FzfLua git_status<cr>", { desc = "Git status files" })
    keymap.set("n", "<leader>ss", "<cmd>lua require('fzf-lua').blines()<cr>", { desc = "Text in Buffer" })

    keymap.set("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "File symbols" })
  end,
}
