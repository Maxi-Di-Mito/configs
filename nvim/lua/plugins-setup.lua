require'hop'.setup()

local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.nvim_workspace();
lsp.setup();


require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    -- dotfiles = true,
  },
})

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"

  ensure_installed = {"javascript", "typescript", "lua", "vue", "json", "html", "css"}, -- one of "all" or a list of languages
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
  },
  indent = {
    enable = true
  }
}

-- FZF
-- setup command for grep search
vim.cmd([[command! -nargs=* -bang Agc call fzf#vim#ag(<q-args>,'--path-to-ignore ~/.vim/.ignore --hidden',fzf#vim#with_preview(),<bang>0)]])
-- setup default search for files
vim.cmd([[let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --path-to-ignore ~/.vim/.ignore -g ""']])

require('fzf_lsp').setup()

-- Lens

vim.g['lens#height_resize_max'] = 80
vim.g['lens#height_resize_min'] = 5
vim.g['lens#width_resize_max'] = 140
vim.g['lens#width_resize_min'] = 20
vim.g['lens#disabled_filetypes'] = {'nerdtree', 'fzf'}

require('lualine').setup({
  options = {
    theme = 'onedark'
  },
  tabline = {
    lualine_a = { 'buffers' }
  },
  sections = {
    lualine_c = {
      {
        'filename',
        path = 1
      }
    },
  }
})
