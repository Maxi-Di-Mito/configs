let mapleader=" "

" split resize
nnoremap <Leader>> 10<C-w>>
nnoremap <Leader>< 10<C-w><

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" Plugs
map <Leader>t :NERDTreeFind<CR>
map <Leader>p :Files<CR>
map <Leader>l :AgC<CR>

" tmux navigator
nnoremap <silent> <Leader><C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <Leader><C-j> :TmuxNagiateDown<cr>
nnoremap <silent> <Leader><C-k> :TmuxNagiateUp<cr>
nnoremap <silent> <Leader><C-l> :TmuxNagiateRight<cr>

" gotos



" buffers
map <Leader>ob :Buffers<cr>

" easy motion
nmap <Leader>s <Plug>(easymotion-s2)

