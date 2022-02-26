function! buffer#selected_text(reselect) abort
  let s = a:reselect ? {} : winsaveview()
  let tmp_register = 'a'
  let register_content = getreg(tmp_register)
  let register_type = getregtype(tmp_register)
  execute 'silent! normal! gv"' . tmp_register . 'y' . (a:reselect ? 'gv' : '')
  let selection = getreg(tmp_register)
  call setreg(tmp_register, register_content, register_type)
  if !a:reselect | call winrestview(s) | endif
  return selection
endfunction
