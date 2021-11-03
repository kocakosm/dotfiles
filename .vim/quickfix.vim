" Better format for quickfix/location list items
function! s:format_quickfix(info) abort
  let items = a:info.quickfix
        \ ? getqflist({'id': a:info.id, 'items': 1}).items
        \ : getloclist(a:info.winid, {'id': a:info.id, 'items': 1}).items
  let fmt = '%S:%S ➤ %S'
  return map(items[a:info.start_idx - 1 : a:info.end_idx - 1],
        \ {_, i -> printf(fmt, bufname(i.bufnr), i.lnum, trim(i.text))})
endfunction

let &quickfixtextfunc = expand('<SID>') . 'format_quickfix'

augroup Quickfix
  autocmd!
  " Close the corresponding location list when quitting a window
  autocmd QuitPre * if &filetype != 'qf' | silent! lclose | endif
augroup END
