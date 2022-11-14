augroup SyntaxComplete
  autocmd!
  autocmd FileType *
        \ if &omnifunc ==# '' |
        \   setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
augroup END
