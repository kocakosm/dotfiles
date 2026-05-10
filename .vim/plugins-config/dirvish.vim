augroup Dirvish
  autocmd!
  autocmd FileType dirvish
        \ setlocal nonumber textwidth=0 cursorlineopt=both |
        \ nmap <silent> <buffer> <esc> gq |
        \ nnoremap <silent> <buffer> <Plug>(dirvish_quit) <cmd>bwipeout<cr> |
        \ execute keymap#conditional('n', 'line(".") == line("$")', '<down>', 'gg', #{global: 0}) |
        \ execute keymap#conditional('n', 'line(".") == line("$")', 'j', 'gg', #{global: 0}) |
        \ execute keymap#conditional('n', 'line(".") == 1', '<up>', 'G', #{global: 0}) |
        \ execute keymap#conditional('n', 'line(".") == 1', 'k', 'G', #{global: 0}) |
        \ call ftplugin#append_undo_cmd('setlocal number< textwidth< cursorlineopt<') |
        \ call ftplugin#append_undo_cmd('execute("nunmap <buffer> <down>")') |
        \ call ftplugin#append_undo_cmd('execute("nunmap <buffer> j")') |
        \ call ftplugin#append_undo_cmd('execute("nunmap <buffer> <up>")') |
        \ call ftplugin#append_undo_cmd('execute("nunmap <buffer> k")') |
        \ call ftplugin#append_undo_cmd('execute("nunmap <buffer> <esc>")') |
        \ call ftplugin#append_undo_cmd('execute("nunmap <buffer> <Plug>(dirvish_quit)")')
augroup END
