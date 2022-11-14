" Prints the current buffer's content to pdf (:hardcopy)

function! s:ps2pdf() abort
  if !executable('ps2pdf')
    throw 'ps2pdf not available'
  endif
  let output_dir = system#user_data_dir() . 'vim/printer/'
  call system#mkdir(output_dir)
  if expand('%')->empty()
    let output_file = $'{output_dir}no_name_{localtime()}.pdf'
  else
    let output_file = $'{output_dir}{expand("%:t")}.pdf'
  endif
  call message#info($'Printing to {output_file}...')
  call system($'ps2pdf {v:fname_in} {output_file}')
  return v:shell_error
endfunction

let &printexpr = expand('<SID>') . 'ps2pdf()'
