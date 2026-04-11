function! keymap#conditional(mode, condition, lhs, rhs, options = {}) abort
  const recursive = a:options->get('recursive', 0)
  const global = a:options->get('global', 1)
  if index(['', 'n', 'v', 'x', 's', 'o', 'i', 'l', 'c', 't'], a:mode) < 0
    throw $'keymap#conditional: unsupported mode mapping ({a:mode})'
  endif
  const mapping = maparg(a:lhs, a:mode, 0, 1)
  const old_rhs = mapping->get('rhs', a:lhs)
  if old_rhs !~ a:rhs
    return printf(
    \  '%s%smap <silent> %s <expr> %s %s ? "%s" : %s',
    \  a:mode, recursive ? '' : 'nore', global ? '' : '<buffer>',
    \  a:lhs, a:condition, a:rhs,
    \  mapping->get('expr', 0) ? $'({old_rhs})' : $'"{old_rhs->escape('"')}"'
    \)
  endif
  return ''
endfunction
