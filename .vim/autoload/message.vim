function! message#info(msg) abort
  echohl None | echomsg a:msg
endfunction

function! message#warn(msg) abort
  echohl WarningMsg | echomsg a:msg | echohl None
endfunction

function! message#error(msg) abort
  echohl ErrorMsg | echomsg a:msg | echohl None
endfunction
