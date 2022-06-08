function! keymap#conditional_map(mode, recursive, condition, lhs, rhs) abort
  if index(['', 'n', 'v', 'x', 's', 'o', 'i', 'l', 'c', 't'], a:mode) < 0
    throw 'keymap#conditional_map: unsupported mode mapping (' . a:mode . ')'
  endif
  let old_rhs = maparg(a:lhs, a:mode)
  if old_rhs !~ a:rhs
    execute printf(
    \  '%s%smap <silent> <expr> %s %s ? "%s" : "%s"',
    \  a:mode, a:recursive ? '' : 'nore', a:lhs, a:condition, a:rhs,
    \  empty(old_rhs) ? a:lhs : old_rhs
    \)
  endif
endfunction
