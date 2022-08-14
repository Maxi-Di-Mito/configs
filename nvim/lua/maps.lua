-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ' '


-- clear search
map('n', '<esc><esc>', ':nohl<CR>')

-- Disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- move between splits
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map('n','<leader>b',':b#<cr>')

-- NvimTree
map('n', '<C-n>', ':NvimTreeToggle<CR>')            -- open/close
map('n', '<leader>f', ':NvimTreeRefresh<CR>')       -- refresh
map('n', '<leader>t', ':NvimTreeFindFile<CR>')      -- search file


-- Fzf
map('n','<leader>ff', ":Files<CR>")
map('n','<leader>fg', ":Agc<CR>")
map('n','<leader>fb', ":Buffers<cr>")
map('n','<leader>fo',':DocumentSymbols<cr>')
map('n','<leader>fd',':Trouble<cr>') -- Diagnostics

-- Hop
map('n','s',':HopChar2<cr>')

-- save and quit mapping
map('n','<leader>w',':w<cr>')
map('n','<leader>q',':q<cr>')

