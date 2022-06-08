function! string#capitalize(input) abort
  return toupper(strcharpart(a:input, 0, 1)) . tolower(strcharpart(a:input, 1))
endfunction

function! string#abbreviate(input, length, ellipsis) abort
  if strchars(a:ellipsis) > a:length
    throw 'string#abbreviate: ellipsis is longer than desired length'
  endif
  if strchars(a:input) <= a:length
    return a:input
  endif
  return strcharpart(a:input, 0, a:length - strchars(a:ellipsis)) . a:ellipsis
endfunction
