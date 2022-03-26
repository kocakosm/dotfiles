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
\    'terminal':#{default: ['Type', 'Bufname', 'Spacer']},
\    'help': #{default: ['Type', 'Filename', 'SearchCount', 'Spacer', 'Ruler']},
\    'qf': #{default: ['Type', 'QuickfixTitle', 'SearchCount', 'Spacer', 'Ruler']},
\    'man': #{default: ['Type', 'Filename', 'SearchCount', 'Spacer']},
\    'nerdtree': #{default: ['Type', 'Spacer']},
\    'vim-plug': #{default: ['Type', 'Spacer']},
\    'fugitive': #{default: ['Type', 'GitHead', 'SearchCount', 'Spacer']},
\    'dirvish': #{default: ['Type', 'Bufname', 'SearchCount', 'Spacer', 'Ruler']}
\  }
\}

set noshowmode
set shortmess+=S
set statusline=%!skyline#get_statusline()

if exists('g:colors_name')
  call skyline#set_theme(g:colors_name)
endif

augroup Statusline
  autocmd!
  autocmd ColorScheme * call skyline#set_theme(expand('<amatch>'))
augroup END
