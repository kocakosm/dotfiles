let g:NERDTreeMinimalUI=1
let g:NERDTreeMouseMode=3
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeHijackNetrw=0
let g:NERDTreeWinSize=40
let g:NERDTreeStatusline=''

nnoremap <silent> <f5> <cmd>NERDTreeToggle<cr>

augroup NerdTree
  autocmd!
  autocmd FileType nerdtree ++once setlocal cursorlineopt=line
augroup END
