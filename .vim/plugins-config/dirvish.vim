augroup Dirvish
  autocmd!
  autocmd FileType dirvish
        \ setlocal nonumber textwidth=0 cursorlineopt=both |
        \ nmap <silent> <buffer> <esc> gq |
        \ nnoremap <silent> <Plug>(dirvish_quit) <cmd>bwipeout<cr> |
        \ execute keymap#conditional('n', 'line(".") == line("$")', '<down>', 'gg', #{global: 0}) |
        \ execute keymap#conditional('n', 'line(".") == line("$")', 'j', 'gg', #{global: 0}) |
        \ execute keymap#conditional('n', 'line(".") == 1', '<up>', 'G', #{global: 0}) |
        \ execute keymap#conditional('n', 'line(".") == 1', 'k', 'G', #{global: 0}) |
        \ call ftplugin#append_undo_cmd('setlocal number< textwidth< cursorlineopt<')
augroup END
