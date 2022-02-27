let g:skyline = #{
\  components: #{
\    Spacer: '%=',
\    Mode: '%( %{statusline#mode()} %)',
\    Type: '%( %{statusline#type()} %)',
\    GitHead: '%( %{statusline#git_head()} %)',
\    FileInfo: '%( %{statusline#file_info()} %)',
\    Filename: '%( %{statusline#filename()} %)',
\    Bufname: '%( %{bufname()} %)',
\    FileType: '%( %{statusline#file_type()} %)',
\    FileFormatAndEncoding: '%( %{statusline#file_format_and_encoding()} %)',
\    Ruler: ' %l/%L %p%%',
\    RulerWithColumns: ' %l/%L:%02.v %p%%',
\    QuickfixTitle: '%( %{statusline#qf_title()} %)',
\    SearchCount: '%( %{statusline#search_count()} %)'
\  },
\  statuslines: {
\    '': #{
\      active: [
\        'Mode', 'GitHead', 'FileInfo', 'SearchCount', 'Spacer',
\        'FileType', 'FileFormatAndEncoding', 'RulerWithColumns'
\      ],
\      inactive: [
\        'FileInfo', 'Spacer',
\        'FileType', 'FileFormatAndEncoding', 'RulerWithColumns'
\      ]
\    },
\    'terminal':#{default: ['Type', 'Bufname']},
\    'help': #{default: ['Type', 'Filename', 'Spacer', 'Ruler']},
\    'qf': #{default: ['Type', 'QuickfixTitle', 'Spacer', 'Ruler']},
\    'man': #{default: ['Type', 'Filename']},
\    'nerdtree': #{default: ['Type']},
\    'vim-plug': #{default: ['Type']},
\    'dirvish': #{default: ['Type', 'Bufname', 'Spacer', 'Ruler']}
\  }
\}

set noshowmode
set statusline=%!skyline#get_statusline()
