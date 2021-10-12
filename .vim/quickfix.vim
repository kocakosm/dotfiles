if !exists('+quickfixtextfunc')
  finish
endif

function! s:format_quickfix(info) abort
  let entries = a:info.quickfix ? getqflist() : getloclist(a:info.winid)
  let max_location_len = 0
  for i in range(a:info.start_idx - 1, a:info.end_idx - 1)
    let entry = entries[i]
    if entry.bufnr ># 0
      let location = bufname(entry.bufnr) . ':' . entry.lnum
      let location_len = strchars(location)
      if location_len ># max_location_len
        let max_location_len = location_len
      endif
      call extend(entry, {'location': location})
    else
      call extend(entry, {'location': ''})
    endif
  endfor
  let fmt = '%-' . max_location_len . 'S %S'
  return map(entries, 'printf(fmt, v:val.location, trim(v:val.text))')
endfunction

" note: expand('<SID>') has been introduced in vim 8.2.1347...
let &quickfixtextfunc = expand('<SID>') . 'format_quickfix'
