function! async#execute(cmd) abort
  call timer_start(0, {-> execute(a:cmd)})
endfunction
