-- FZF
-- setup command for grep search
vim.cmd(
	[[command! -nargs=* -bang Agc call fzf#vim#ag(<q-args>,'--path-to-ignore ~/configs/.ignore --hidden',fzf#vim#with_preview(),<bang>0)]]
)

vim.cmd([[command! -bang -nargs=* CustomBLines
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
    \   fzf#vim#with_preview({'options': '--keep-right --delimiter : --nth 4.. --preview "bat -p --color always {}"'}, 'right:60%' ))
  ]])

-- setup default search for files
vim.cmd([[let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --path-to-ignore ~/configs/.ignore -g ""']])

require("fzf_lsp").setup()

-- Fix to scroll on fzf popup
vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-j> <Down>]])
vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-k> <Up>]])
vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-h> <nop>]])
vim.cmd([[ autocmd FileType fzf tnoremap <buffer> <C-l> <nop>]])

vim.env.BAT_THEME = "tokyo-theme-moon"
