function! git#head() abort
  if !exists('b:git_head')
    let b:git_head = s:get_git_head()
  endif
  return b:git_head
endfunction

function! s:get_git_head() abort
  if !executable('git')
    throw 'git#head: git not available'
  endif
  let dir = expand('%:p:h')
  let head = s:execute('git -C ' . dir . ' branch --show-current')
  if empty(head)
    let head = s:execute('git -C ' . dir . ' rev-parse --short=7 HEAD')
  endif
  return head
endfunction

function! s:execute(cmd) abort
  silent let result = system(a:cmd)
  return v:shell_error ? '' : trim(result)
endfunction

augroup GitHead
  autocmd!
  autocmd BufEnter,DirChanged * let b:git_head = <sid>get_git_head()
augroup END
