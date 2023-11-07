function! buffer#selected_text(reselect) abort
  let s = a:reselect ? {} : winsaveview()
  let tmp_register = 'a'
  let register_content = getreg(tmp_register)
  let register_type = getregtype(tmp_register)
  try
    execute 'silent! normal! gv"' . tmp_register . 'y' . (a:reselect ? 'gv' : '')
    return getreg(tmp_register)
  finally
    call setreg(tmp_register, register_content, register_type)
    if !a:reselect | call winrestview(s) | endif
  endtry
endfunction

function! buffer#duplicate_line_up() abort
  let save_virtualedit = &l:virtualedit
  try
    setlocal virtualedit=onemore
    normal m`yyP==``k
  finally
    let &l:virtualedit = save_virtualedit
  endtry
endfunction

function! buffer#duplicate_line_down() abort
  let save_virtualedit = &l:virtualedit
  try
    setlocal virtualedit=onemore
    normal m`yyp==``j
  finally
    let &l:virtualedit = save_virtualedit
  endtry
endfunction
