" COC Config -----------------------------
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr :CocCommand fzf-preview.CocReferences<CR>
" autocmd CursorHold *.js silent call g:lens#run()


" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

let g:coc_global_extensions = [ 'coc-json', 'coc-tsserver', 'coc-prettier', 'coc-eslint', 'coc-fzf-preview', '@yaegassy/coc-volar' ]

autocmd CursorHold * silent call CocActionAsync('highlight')

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Nerdtree
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeShowLineNumbers=1

" Fzf

let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'],
  \ }
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
autocmd VimEnter * command! -nargs=* -bang AgC call fzf#vim#ag(<q-args>, '--path-to-ignore ~/.vim/.ignore --hidden --ignore "node_modules" --ignore-dir="vendor" --skip-vcs-ignores', <bang>0)
let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.7, 'yoffset': '-1', 'border': 'rounded' } }

" add_list_source(name, description, command)
call coc_fzf#common#add_list_source('fzf-buffers', 'display open buffers', 'Buffers')

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="simple"

" rainbow brackets
let g:rainbow_active = 1

" Lens auto resize
let g:lens#height_resize_max = 80
let g:lens#height_resize_min = 5
let g:lens#width_resize_max = 140
let g:lens#width_resize_min = 15
