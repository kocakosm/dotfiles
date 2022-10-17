function! print#to_pdf() abort
  if !executable('ps2pdf')
    throw 'print#to_pdf: ps2pdf not available'
  endif
  call system($'ps2pdf {v:fname_in} {expand("%:p:r")}.pdf')
  return v:shell_error
endfunction
