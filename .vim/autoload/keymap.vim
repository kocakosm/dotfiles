function! keymap#conditional_map(mode, condition, lhs, rhs, ...) abort
  if a:0 > 1
    throw 'keymap#conditional_map: too many arguments'
  endif
  let options = a:0 ? a:1 : {}
  let recursive = options->get('recursive', 0)
  let global = options->get('global', 1)
  if index(['', 'n', 'v', 'x', 's', 'o', 'i', 'l', 'c', 't'], a:mode) < 0
    throw 'keymap#conditional_map: unsupported mode mapping (' . a:mode . ')'
  endif
  let old_rhs = maparg(a:lhs, a:mode)
  if old_rhs !~ a:rhs
    execute printf(
    \  '%s%smap <silent> %s <expr> %s %s ? "%s" : "%s"',
    \  a:mode, recursive ? '' : 'nore', global ? '' : '<buffer>',
    \  a:lhs, a:condition, a:rhs, empty(old_rhs) ? a:lhs : old_rhs
    \)
  endif
endfunction
