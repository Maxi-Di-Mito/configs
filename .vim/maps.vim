let mapleader=" "

" split resize
nnoremap <Leader>> 10<C-w>>
nnoremap <Leader>< 10<C-w><
nnoremap <silent> <Leader>re :call g:lens#run()<CR>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>wq :wq<CR>

" Plugs
map <Leader>t :NERDTreeFind<CR>
map <Leader>ff :Files<CR>
map <Leader>fg :AgC<CR>
nnoremap <silent> <space>fo :<C-u>CocFzfList outline<CR>
nnoremap <silent> <space>fb :CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> <space>fd :CocCommand fzf-preview.CocCurrentDiagnostics<CR>
nnoremap <silent> <space>ft :<C-u>BLines<CR>

" tmux navigator
nnoremap <silent> <Leader><C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <Leader><C-j> :TmuxNagiateDown<cr>
nnoremap <silent> <Leader><C-k> :TmuxNagiateUp<cr>
nnoremap <silent> <Leader><C-l> :TmuxNagiateRight<cr>

" gotos

" Hop-nvim
nmap <silent> <Leader>h :HopChar2<cr>

