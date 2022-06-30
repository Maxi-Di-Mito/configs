set number
set mouse=a
set numberwidth=1
set clipboard=unnamed
syntax on
set showcmd
set ruler
set cursorline
set encoding=utf-8
set showmatch
set sw=2
set relativenumber
so ~/.vim/plugins.vim
so ~/.vim/plugin-config.vim
so ~/.vim/maps.vim

colorscheme gruvbox
let g:gruvbox_contrast_dark = "hard"
highligh Normal ctermbg=NONE
set laststatus=2
set noshowmode

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

