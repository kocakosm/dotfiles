" Use built-in formatexpr
setlocal formatexpr=dist#json#FormatExpr()
call ftplugin#append_undo_cmd('setlocal formatexpr<')

" Define the Format command for formatting the whole buffer
function! s:json_format() abort
  let view = winsaveview()
  if executable('jq')
    let cmd = printf('jq %s .', &expandtab ? '--indent ' . &shiftwidth : '--tab')
    silent! let result = systemlist(cmd, getline(1, '$'))
    if v:shell_error
      call message#error(join(result, ' '))
    else
      silent! keepjumps normal! gg_dG
      call setline(1, result)
    endif
  else
    silent! keepjumps normal! gggqG
  endif
  call winrestview(view)
endfunction

command! -buffer -bar Format call <sid>json_format()
call ftplugin#append_undo_cmd('delcommand Format')

" Disable concealing
let g:vim_json_conceal=0
