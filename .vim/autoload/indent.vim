function! indent#append_undo_cmd(cmd) abort
  if exists('b:undo_indent') && len(b:undo_indent)
    let b:undo_indent .= ' | ' . a:cmd
  else
    let b:undo_indent = a:cmd
  endif
endfunction
