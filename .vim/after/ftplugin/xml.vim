function! s:xml_format() abort
  let view = winsaveview()
  if executable('xmlstarlet')
    let cmd = 'xmlstarlet format '
    let cmd .= '-e ' . (&fileencoding !=# '' ? &fileencoding : &encoding)
    let cmd .= &expandtab ? ' -s ' . &shiftwidth : ' -t'
    silent! let result = systemlist(cmd, getline(1, '$'))
    if v:shell_error != 0 && v:shell_error < 50
      let result[0] = strcharpart(result[0], stridx(result[0], ':') + 1, strchars(result[0]))
      for error in result | call message#error(error) | endfor
    else
      silent! keepjumps normal! gg_dG
      call setline(1, result)
    endif
  else
    silent! keepjumps normal! gggqG
  endif
  call winrestview(view)
endfunction

command! -buffer -bar Format call <sid>xml_format()
call ftplugin#append_undo_cmd('delcommand Format')
