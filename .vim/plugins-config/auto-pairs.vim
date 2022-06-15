augroup AutoPairs
  autocmd!
  autocmd FileType vim let b:AutoPairs=filter(g:AutoPairs, "v:key !~# '\"'")
augroup END
