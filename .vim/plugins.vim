call plug#begin('~/.vim/plugged')

" Syntax
Plug 'sheerun/vim-polyglot'
" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'pantharshit00/vim-prisma'

" Themes
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'

" Tree
Plug 'scrooloose/nerdtree'

" Typing
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'

" Tmux
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" autocomplete
"Plug 'sirver/ultisnips'
Plug 'neoclide/coc.nvim',{'branch':'release'}
" IDE
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'
Plug 'mhinz/vim-signify'
Plug 'yggdroot/indentline'
Plug 'phaazon/hop.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'APZelos/blamer.nvim'

call plug#end()

lua <<EOF
	require'hop'.setup()

	local status_ok, configs = pcall(require, "nvim-treesitter.configs")
	if not status_ok then
		return
	end

	configs.setup({
		ensure_installed = {"javascript", "typescript", "lua", "vue", "json", "html", "css"}, -- one of "all" or a list of languages
		ignore_install = { "" }, -- List of parsers to ignore installing
		highlight = {
			enable = true, -- false will disable the whole extension
			disable = "", -- list of language that will be disabled
		},
		autopairs = {
			enable = true,
		},
		indent = { enable = true, disable = { "python", "css" } },
		auto_install = true
	})
EOF

