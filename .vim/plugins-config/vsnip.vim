let g:vsnip_snippet_dir = system#USER_VIM_DIR . 'snippets'

call keymap#conditional_map('i', v:true, 'vsnip#available(1)', '<tab>', '<plug>(vsnip-expand-or-jump)')
call keymap#conditional_map('s', v:true, 'vsnip#available(1)', '<tab>', '<plug>(vsnip-expand-or-jump)')
call keymap#conditional_map('i', v:true, 'vsnip#jumpable(-1)', '<s-tab>', '<plug>(vsnip-jump-prev)')
call keymap#conditional_map('s', v:true, 'vsnip#jumpable(-1)', '<s-tab>', '<plug>(vsnip-jump-prev)')

nmap s <plug>(vsnip-select-text)
xmap s <plug>(vsnip-select-text)
nmap S <plug>(vsnip-cut-text)
xmap S <plug>(vsnip-cut-text)
