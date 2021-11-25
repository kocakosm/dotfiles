scriptencoding utf-8

let g:lsp_settings_servers_dir=expand('$XDG_DATA_HOME/lsp/servers')
let g:lsp_settings_global_settings_dir=expand('$XDG_DATA_HOME/vim/lsp')

call mkdir(g:lsp_settings_servers_dir, 'p', 0700)
call mkdir(g:lsp_settings_global_settings_dir, 'p', 0700)
