" Do not highlight html and markdown in javadocs
let g:java_ignore_html = 1
let g:java_ignore_markdown = 1

" Automatically insert the comment leader after hitting <Enter> in insert mode
setlocal formatoptions+=r

" Automatically insert the comment leader after hitting 'o'/'O' in normal mode
setlocal formatoptions+=o

" <c-l> moves successively the cursor to the next unmatched ')',
" to the end of the line or to the next unmatched '}'
function! s:end() abort
  if mode() ==# 'i' && getcursorcharpos()[2] > 1
    normal! h
  endif
  for m in ['])', '$', ']}']
    if cursor#Move(m) | break | endif
  endfor
  if mode() ==# 'i'
    const virtualedit = &l:virtualedit
    try
      let &l:virtualedit = 'onemore'
      normal! l
    finally
      let &l:virtualedit = virtualedit
    endtry
  endif
endfunction
inoremap <silent> <buffer> <c-l> <cmd>call <sid>end()<cr>
nnoremap <silent> <buffer> <c-l> <cmd>call <sid>end()<cr>

" Undo commands
call ftplugin#append_undo_cmd('setlocal formatoptions<')
call ftplugin#append_undo_cmd('execute("iunmap <buffer> <c-l>")')
call ftplugin#append_undo_cmd('execute("nunmap <buffer> <c-l>")')
