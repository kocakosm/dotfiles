if executable('xmlstarlet')
  function! s:xmlstarlet_format() abort
    let cmd = 'xmlstarlet format '
    let cmd .= '-e ' . (&fileencoding !=# '' ? &fileencoding : &encoding)
    let cmd .= &expandtab ? ' -s ' . &shiftwidth : ' -t'
    silent! let result = systemlist(cmd, getline(1, '$'))
    if v:shell_error != 0 && v:shell_error < 50
      let result[0] = strcharpart(result[0], stridx(result[0], ':') + 1, strchars(result[0]))
      for error in result | call message#error(error) | endfor
    else
      silent! normal! gg_dG
      call setline(1, result)
    endif
  endfunction
  command! -buffer -bar Format call <sid>xmlstarlet_format()
endif

" Undo commands
call ftplugin#append_undo_cmd('delcommand Format')
