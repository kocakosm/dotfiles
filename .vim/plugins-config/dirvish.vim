augroup Dirvish
  autocmd!
  autocmd FileType dirvish
        \ setlocal nonumber signcolumn=yes |
        \ call keymap#conditional_map('n', 'line(".") == line("$")', '<down>', 'gg', #{global: 0}) |
        \ call keymap#conditional_map('n', 'line(".") == line("$")', 'j', 'gg', #{global: 0}) |
        \ call keymap#conditional_map('n', 'line(".") == 1', '<up>', 'G', #{global: 0}) |
        \ call keymap#conditional_map('n', 'line(".") == 1', 'k', 'G', #{global: 0}) |
        \ call ftplugin#append_undo_cmd('setlocal number< signcolumn<')
augroup END
