let s:lsp_servers_dir = system#USER_DATA_HOME . 'lsp/servers/'

let g:lsc_server_commands = #{
\  java: #{
\    enabled: v:false,
\    command: s:lsp_servers_dir . 'eclipse-jdt-ls/eclipse-jdt-ls'
\  }
\}
let g:lsc_enable_autocomplete = v:false
let g:lsc_auto_map = #{defaults: v:true, Completion: 'omnifunc'}
