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
  end,
}
