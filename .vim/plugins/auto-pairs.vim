scriptencoding utf-8

augroup AutoPairs
  autocmd!
  autocmd Filetype vim let b:AutoPairs=filter(g:AutoPairs, "v:key !~# '\"'")
augroup END
