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

function! buffer#selected_text() abort
  let mode = mode()
  let visual = mode ==? 'v' || mode ==? ''
  let start = visual ? 'v' : "'<"
  let end = visual ? '.' : "'>"
  let type = visual ? mode : visualmode()
  return getregion(getpos(start), getpos(end), #{type: type})
endfunction
