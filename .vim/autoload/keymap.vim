function! keymap#conditional_imap(condition, lhs, rhs) abort
  let old_rhs = maparg(a:lhs, 'i')
  if empty(old_rhs)
    let old_rhs = a:lhs
  endif
  if old_rhs !~ a:rhs
    execute 'inoremap <silent> <expr> ' . a:lhs . ' '
          \ . a:condition . ' ? "' . a:rhs . '" : "' . old_rhs . '"'
  endif
endfunction
