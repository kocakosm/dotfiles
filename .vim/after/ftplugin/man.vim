" Wipe the buffer when it is no longer displayed
call ex#execute_with_delay(50, 'setlocal bufhidden=wipe')

nnoremap <silent> <buffer> <up> <c-y>
nnoremap <silent> <buffer> <down> <c-e>
nnoremap <silent> <buffer> <left> <nop>
nnoremap <silent> <buffer> <right> <nop>
nnoremap <silent> <buffer> k <c-y>
nnoremap <silent> <buffer> j <c-e>
nnoremap <silent> <buffer> h <nop>
nnoremap <silent> <buffer> l <nop>

" Undo commands
call ftplugin#append_undo_cmd('setlocal bufhidden<')
call ftplugin#append_undo_cmd('nunmap <buffer> <up>')
call ftplugin#append_undo_cmd('nunmap <buffer> <down>')
call ftplugin#append_undo_cmd('nunmap <buffer> <left>')
call ftplugin#append_undo_cmd('nunmap <buffer> <right>')
call ftplugin#append_undo_cmd('nunmap <buffer> k')
call ftplugin#append_undo_cmd('nunmap <buffer> j')
call ftplugin#append_undo_cmd('nunmap <buffer> h')
call ftplugin#append_undo_cmd('nunmap <buffer> l')
