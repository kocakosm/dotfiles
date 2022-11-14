vim9script

export def Head(): string
  if !exists('b:git_head')
    UpdateGitHead()
  endif
  return b:git_head
enddef

def UpdateGitHead(): void
  b:git_head = GetGitHead()
enddef

def GetGitHead(): string
  if !executable('git')
    throw 'git#Head: git not available'
  endif
  const dir = expand('%:p:h')
  var head = Execute($'git -C {dir} branch --show-current')
  if empty(head)
    head = Execute($'git -C {dir} name-rev --name-only --tags HEAD')
    if head =~ '\^0$'
      head = head->substitute('\^0$', '', '')
    else
      head = Execute($'git -C {dir} rev-parse --short=8 HEAD')
    endif
  endif
  return head
enddef

def Execute(cmd: string): string
  silent const result = system(cmd)
  return v:shell_error != 0 ? '' : result->trim()
enddef

augroup GitHead
  autocmd!
  autocmd BufEnter,DirChanged,FocusGained * UpdateGitHead()
augroup END
