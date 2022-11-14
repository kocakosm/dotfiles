" Diffs the current buffer and the file it was loaded from

function! s:diff_origin() abort
  if &buftype != '' || empty(bufname('%'))
    call message#warn('[DiffOrigin] N/A')
    return
  endif
  vertical new
  setlocal bufhidden=wipe buftype=nofile nobuflisted noswapfile
  read ++edit #
  let &filetype = getbufvar('#', '&filetype')
  silent 0d_
  setlocal readonly
  diffthis | wincmd p | diffthis
endfunction

command! DiffOrigin call <sid>diff_origin()
