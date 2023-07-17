local fzf = require("fzf-lua")

fzf.setup({})

-- Fix to scroll on fzf popup
vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-j> <Down>]])
vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-k> <Up>]])
vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-h> <nop>]])
vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-l> <nop>]])

--[[ vim.env.BAT_THEME = "tokyo-theme-moon" ]]
