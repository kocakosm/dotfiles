function! keymap#conditional_imap(condition, lhs, rhs) abort
  let old_rhs = maparg(a:lhs, 'i')
  if old_rhs !~ a:rhs
    execute printf(
    \  'inoremap <silent> <expr> %s %s ? "%s" : "%s"',
    \  a:lhs, a:condition, a:rhs, empty(old_rhs) ? a:lhs : old_rhs
    \)
  endif
endfunction
