let mapleader=" "

" split resize
nnoremap <Leader>> 10<C-w>>
nnoremap <Leader>< 10<C-w><

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>wq :wq<CR>

" Plugs
map <Leader>t :NERDTreeFind<CR>
map <Leader>ff :Files<CR>
map <Leader>ft :AgC<CR>
nnoremap <silent> <space>fo :<C-u>CocFzfList outline<CR>
nnoremap <silent> <space>fs :<C-u>CocFzfList symbols<CR>
nnoremap <silent> <space>fa :<C-u>CocFzfList<CR>
nnoremap <silent> <space>fb :<C-u>CocFzfList fzf-buffers<CR>
nnoremap <silent> <space>fd :<C-u>CocFzfList diagnostics --current-buf<CR>

" tmux navigator
nnoremap <silent> <Leader><C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <Leader><C-j> :TmuxNagiateDown<cr>
nnoremap <silent> <Leader><C-k> :TmuxNagiateUp<cr>
nnoremap <silent> <Leader><C-l> :TmuxNagiateRight<cr>

" gotos

" Hop-nvim
nmap <silent> <Leader>fw :HopChar2<cr>

