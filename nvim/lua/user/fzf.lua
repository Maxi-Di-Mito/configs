local fzf = require("fzf-lua")

fzf.setup({})

-- Viejo para el fzf.vim
-- Fix to scroll on fzf popup
--vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-j> <Down>]])
--vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-k> <Up>]])
--vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-h> <nop>]])
--vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-l> <nop>]])

vim.cmd([[tnoremap <PageUp> <C-\><C-n>:lua require('fzf-lua.previewer.builtin').base.scroll(-1)<CR>i]])
vim.cmd([[tnoremap <PageDown> <C-\><C-n>:lua require('fzf-lua.previewer.builtin').base.scroll(1)<CR>i]])

--[[ vim.env.BAT_THEME = "tokyo-theme-moon" ]]
