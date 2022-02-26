let g:ctrlp_line_prefix=' '
let g:ctrlp_cache_dir=system#USER_DATA_HOME . 'vim/ctrlp'
call mkdir(g:ctrlp_cache_dir, 'p', 0700)
if executable('ag')
  let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching=0
elseif executable('fdfind')
  let g:ctrlp_user_command='fdfind -H -L -E ".git" -c never "" %s'
  let g:ctrlp_use_caching=0
else
  let g:ctrlp_clear_cache_on_exit=1
endif
let g:ctrlp_types = ['fil', 'buf']
let g:ctrlp_extensions=['tag', 'quickfix', 'line', 'changes']
"let g:ctrlp_match_window='top,order:ttb,min:0,max:20'
let g:ctrlp_max_history=0
let g:ctrlp_match_current_file=1
"let g:ctrlp_lazy_update=1

function! s:force_buf_win_enter() abort
  call feedkeys(":doautocmd BufWinEnter | echo \<cr>")
endfunction

let g:ctrlp_buffer_func={'exit': expand('<SID>') . 'force_buf_win_enter'}
