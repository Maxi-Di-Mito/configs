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
nmap <silent> gr <Plug>(coc-references)

if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=no
endif

let g:coc_global_extensions = [ 'coc-json', 'coc-tsserver', 'coc-prettier', 'coc-eslint' ]

autocmd CursorHold * silent call CocActionAsync('highlight')

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Nerdtree
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1

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

" LightLine
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename' ] ],
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
      \ }
" Show full path of filename
function! LightlineFilename()
    return expand('%')
endfunction
