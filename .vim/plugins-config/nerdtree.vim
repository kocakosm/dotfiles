let g:NERDTreeMinimalUI=1
let g:NERDTreeMouseMode=3
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeHijackNetrw=0
let g:NERDTreeWinSize=40
let g:NERDTreeStatusline=''
let g:NERDTreeDirArrowExpandable='▶'
let g:NERDTreeDirArrowCollapsible='▼'

nnoremap <silent> <f5> <cmd>NERDTreeToggle<cr>

" this is a hack to prevent splitting the NERDTree window...
function! s:close_splits() abort
  const nerdtrees = range(1, winnr('$'))
        \ ->filter({_, v -> getwinvar(v, '&winhighlight') =~? 'nerdtree'})
  for i in nerdtrees[1:]
    execute i . 'wincmd w'
    if getwinvar(i, '&filetype') ==? 'nerdtree'
      quit
    else
      bwipeout
    endif
  endfor
  if !empty(nerdtrees[1:])
    execute nerdtrees[0] . 'wincmd w'
    silent doautocmd User CursorAutoHide
  endif
endfunction

augroup NerdTree
  autocmd!
  autocmd FileType nerdtree
        \ setlocal cursorlineopt=line |
        \ call ftplugin#append_undo_cmd('setlocal cursorlineopt<')
  autocmd SafeState * call <sid>close_splits()
augroup END
