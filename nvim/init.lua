require("user.configs")
require("user.keymaps")
require("user.autocmds")

require("user.plugins")
require("user.autopairs")
require("user.bufferline")
require("user.comment")
require("user.fzf")
require("user.gitsigns")
require("user.indent-blankline")
require("user.hop")
require("user.nvim-tree")
require("user.treesitter")
--[[ require("user.lsp.lsp-config") ]]
--[[ require("user.lsp.mason") ]]
--[[ require("user.lsp.lspsaga") ]]
require("user.tmux-navigator")
require("user.lsp-zero")
require("user.which-key")
require("user.null-ls")
require("user.lualine")
require("user.colorizer")

pcall(vim.cmd, "colorscheme tokyonight-moon")
