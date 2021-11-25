" Use jq (if available) to indent/format json
if executable('jq')
  function! s:jq_format() abort
    let cmd = printf('jq %s .', &expandtab ? '--indent ' . &shiftwidth : '--tab')
    silent! let result = systemlist(cmd, getline(1, '$'))
    if v:shell_error
      echohl ErrorMsg | echomsg join(result, ' ') | echohl None
    else
      silent! normal! gg_dG
      call setline(1, result)
    endif
  endfunction
  command! -buffer -bar Format call <sid>jq_format()
endif

" Undo commands
let b:undo_ftplugin = 'delcommand Format'
