" Better format for quickfix/location list items
if exists('+quickfixtextfunc')
  function! s:format_quickfix(info) abort
    let items = a:info.quickfix
          \ ? getqflist({'id': a:info.id, 'items': 1}).items
          \ : getloclist(a:info.winid, {'id': a:info.id, 'items': 1}).items
    let items = items[a:info.start_idx - 1 : a:info.end_idx - 1]
    let max_location_len = 0
    for item in items
      if item.bufnr ># 0
        let location = bufname(item.bufnr) . ':' . item.lnum
        let location_len = strchars(location)
        if location_len ># max_location_len
          let max_location_len = location_len
        endif
        call extend(item, {'location': location})
      else
        call extend(item, {'location': ''})
      endif
    endfor
    let fmt = '%-' . max_location_len . 'S %S'
    return map(items, {_, i -> printf(fmt, i.location, trim(i.text))})
  endfunction
  let &quickfixtextfunc = expand('<SID>') . 'format_quickfix'
endif

" Automatically close the location list when quitting its corresponding window
augroup AutoCloseLocationList
    autocmd!
    autocmd QuitPre * nested if &filetype != 'qf' | silent! lclose | endif
augroup END
