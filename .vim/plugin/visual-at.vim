function! s:visual_at() abort
  if mode() ==# 'V'
    echo '@'
    let register = getchar()->nr2char()
    call feedkeys(':', 'nx')
    if register !~# '[0-9a-z@".=*+\e]'
      call message#warn($'Invalid register "{register}"')
    elseif register !~# '\e'
      echo $'@{register}'
      execute $":'<,'> normal @{register}"
    endif
  else
    call message#warn('Only visual line mode is supported')
  endif
endfunction

xnoremap <silent> @ <cmd>call <sid>visual_at()<cr>
