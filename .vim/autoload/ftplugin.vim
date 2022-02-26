function! ftplugin#append_undo_cmd(cmd) abort
  if exists('b:undo_ftplugin') && len(b:undo_ftplugin)
    let b:undo_ftplugin .= ' | ' . a:cmd
  else
    let b:undo_ftplugin = a:cmd
  endif
endfunction
