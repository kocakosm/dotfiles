function! ex#execute_with_delay(delay, cmd) abort
  call timer_start(a:delay, {-> execute(a:cmd)})
endfunction
