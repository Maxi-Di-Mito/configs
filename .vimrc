set number
set mouse=a
set clipboard=unnamed
syntax on
set showcmd
set ruler
set cursorline
set encoding=utf-8
set showmatch
set sw=2
set relativenumber
set signcolumn=yes " Always show signcolumn
set updatetime=500 
set splitright " Open vplit buffer to the right
set iskeyword+=- " treat dash-separated-words as word text object
set wildmenu " Enhanced tabline completion
so ~/.vim/plugins.vim
so ~/.vim/plugin-config.vim
so ~/.vim/maps.vim

" let g:gruvbox_contrast_dark = "hard"
colorscheme gruvbox
highligh Normal ctermbg=NONE
set laststatus=2
set noshowmode

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
" Clear search highlighting with escape x2
nnoremap <silent><esc><esc> :nohlsearch<CR>

" Scroll cursor offset
let &scrolloff = &lines / 3
