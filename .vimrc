" Disable vi compatibility
set nocompatible

" Set UTF-8 as the default encoding
set encoding=utf-8
set termencoding=utf-8
setglobal fileencoding=utf-8

" Disable modeline
set nomodeline

" Enable the mouse
set mouse=a

" Hide the mouse when a key is pressed
set mousehide

" Automatically switch to the directory of the current file
set autochdir

" Automatically reload files when modified by an external program
set autoread

" Automatically save buffer before :next, :make etc...
"set autowrite

" Ask to save modified files before operations like :q
"set confirm

" Better display when running in a terminal
set ttyfast

" Don't redraw when running macros
set lazyredraw

" Allow more than one unsaved buffer
set hidden

" Enhanced command-line completion
set wildmenu
set wildmode=longest,full

" Case insensitive command-line completion
set wildignorecase

" Don't try to open these files/directories
set wildignore+=.hg,.git,.svn
set wildignore+=*.png,*.jpg,*.jpeg,*.gif
set wildignore+=*.o,*.pyc,*.pyo,*.class
set wildignore+=*.aux,*.log,*.dvi,*.bbl,*.blg,*.out,*.toc
set wildignore+=*.orig

" Don't keep backups
set nobackup
set nowritebackup

" Don't create swap files
"set noswapfile

" Save undo tree to disk
set undofile

" Put all temporary files under ~/.vim/tmp
function! s:mkdir(path) abort
  if !isdirectory(a:path) | call mkdir(a:path, 'p') | endif
endfunction
call s:mkdir($HOME . '/.vim/tmp/swap')
call s:mkdir($HOME . '/.vim/tmp/undo')
call s:mkdir($HOME . '/.vim/tmp/info')
call s:mkdir($HOME . '/.vim/tmp/backup')
set backupdir=$HOME/.vim/tmp/backup/
set directory=$HOME/.vim/tmp/swap//
set undodir=$HOME/.vim/tmp/undo/
set viminfo='100,n$HOME/.vim/tmp/info/viminfo

" Set the window title
set title
set titlestring=%F\ %m

" Don't display the intro message
set shortmess+=I

" Display commands as they are typed
set showcmd

" Show the current mode
set showmode

" Always show the status line
set laststatus=2

" Show the cursor position
set ruler

" Show line numbers
set number

" Use 4 columns for line numbers
set numberwidth=4

" Prettier vertical split line
set fillchars=vert:\│

" Open new windows below the current one
set splitbelow

" Open new windows at the right-hand side of the current one
set splitright

" Maximum text width (0 means don't cut lines)
set textwidth=0

" Highlight column after 'textwidth' (when > 0)
set colorcolumn=+1

" Don't wrap long lines by default
set nowrap

" Add a ↪ at the start of lines that have been wrapped
let &showbreak='↪ '

" Visually indent wrapped lines
set breakindent

" Shift wrapped line's beginning by 1 character
set breakindentopt=shift:1

" Only wrap at a character in the 'breakat' option
set linebreak

" Show as much as possible of the last line
set display+=lastline

" Highlight matching brackets
set showmatch
set matchtime=3

" Disable folding by default
set nofoldenable

" Fold using indentation
set foldmethod=indent

" Show folding marks
"set foldcolumn=1

" Try to keep 1 line above and below the cursor
set scrolloff=1

" Side-scroll 5 characters before the screen border
set sidescrolloff=5

" Side-scroll 1 character at a time
set sidescroll=1

" Try to keep the cursor at the current column when jumping to other lines
set nostartofline

" Show tabs, non-printable characters, etc...
"let &listchars='tab:┊ '
"let &listchars='tab:▸ ,extends:❯,precedes:❮,trail:·,eol:¬'
"let &listchars='trail:•'
"augroup List
"  autocmd!
"  autocmd InsertEnter * set nolist
"  autocmd InsertLeave * set list
"augroup END

" More powerful backspacing in insert mode
set backspace=indent,eol,start

" Allow <left>/<right> and h/l to wrap the cursor around line borders
set whichwrap=<,>,h,l,[,]

" Enable virtual editing in visual block mode
set virtualedit=block

" Smart automatic indentation
set autoindent
set smartindent

" Expand tabulations to spaces
set expandtab

" Use 4 characters-wide tabulations
set softtabstop=4
set tabstop=4
set smarttab

" Use 4 characters as indentation level
set shiftwidth=4

" >> indents to next multiple of 'shiftwidth'
set shiftround

" Files to scan for <c-x><c-k> insert mode completions
set dictionary=/usr/share/dict/*-english,/usr/share/dict/french

" Places to scan for <c-n>, <c-p> and <c-x><c-l> insert mode completions
"set complete=.,w,b,u,t,i,kspell,k

" Insert mode completion options
set completeopt=longest,menu,preview

" Enable syntax-based completion for file types that don't have custom completion scripts
augroup SyntaxCompletion
  autocmd!
  autocmd FileType * if &omnifunc == '' | setlocal omnifunc=syntaxcomplete#Complete | endif
augroup END

" Adjust the case of the completion match to the case of the typed text
"set infercase

" Don't show more than 10 items in the popup menu
set pumheight=10

" Automatic formatting options
set formatoptions+=jln

" Use system's default clipboards for yanking/pasting
if has('unnamedplus')
  set clipboard=unnamedplus
endif
set clipboard+=unnamed

" Case insensitive search
set ignorecase

" Smart case sensitivity (has priority over ignorecase)
set smartcase

" Enable incremental search
set incsearch

" Don't highlight search results by default
set nohlsearch

" Load plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
source $HOME/.vim/plugins.vim

" Enable file type detection
filetype plugin indent on

" Enable syntax highlighting
syntax on

" Finer-grained undo
inoremap <silent> <tab> <tab><c-g>u
inoremap <silent> <space> <space><c-g>u
inoremap <silent> <return> <return><c-g>u

" Finer-grained scrolling with mouse wheel
"noremap <silent> <scrollwheelup> <c-y><c-y>
"inoremap <silent> <scrollwheelup> <c-o><c-y><c-o><c-y>
"noremap <silent> <scrollwheeldown> <c-e><c-e>
"inoremap <silent> <scrollwheeldown> <c-o><c-e><c-o><c-e>
"noremap <silent> <c-scrollwheelup> <c-y>
"inoremap <silent> <c-scrollwheelup> <c-o><c-y>
"noremap <silent> <c-scrollwheeldown> <c-e>
"inoremap <silent> <c-scrollwheeldown> <c-o><c-e>
"noremap <silent> <s-scrollwheelup> <c-u>
"inoremap <silent> <s-scrollwheelup> <c-o><c-u>
"noremap <silent> <s-scrollwheeldown> <c-d>
"inoremap <silent> <s-scrollwheeldown> <c-o><c-d>

" Make <up>/<down> move by virtual lines in insert mode
inoremap <up> <c-o>gk
inoremap <down> <c-o>gj

" Make j/k/<up>/<down> move by virtual lines unless when used with a count
"noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
"noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
"noremap <silent> <expr> <down> (v:count == 0 ? 'gj' : 'j')
"noremap <silent> <expr> <up> (v:count == 0 ? 'gk' : 'k')

" K splits the current line (opposite of J)
nnoremap <silent> K i<cr><esc>

" Y yanks from the cursor to the end of the line
nnoremap <silent> Y y$

" <ctrl>-t opens a new tab
noremap <silent> <c-t> :tabnew<cr>
inoremap <silent> <c-t> <c-o>:tabnew<cr>

" <alt>-<up> switches to the next tab
noremap <silent> <a-up> gt
inoremap <silent> <a-up> <c-o>gt

" <alt>-<down> switches to the previous tab
noremap <silent> <a-down> gT
inoremap <silent> <a-down> <c-o>gT

" <alt>-<right> switches to the next buffer
noremap <silent> <a-right> :bn!<cr>
inoremap <silent> <a-right> <c-o>:bn!<cr>

" <alt>-<left> switches to the previous buffer
noremap <silent> <a-left> :bp!<cr>
inoremap <silent> <a-left> <c-o>:bp!<cr>

" <space> centers the current line
noremap <silent> <space> zz

" gp reselects last pasted text
nnoremap <silent> <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Don't lose visual selection when shifting sidewards
xnoremap <silent> < <gv
xnoremap <silent> > >gv

" \s sorts the current visual selection
xnoremap <silent> <leader>s :sort<cr>

" \h toggles search results highlighting
nnoremap <silent> <leader>h :setlocal hlsearch!<cr>

" \<space> toggles spell-checking
nnoremap <silent> <leader><space> :setlocal spell!<cr>

" Easily replace the word under the cursor or the current visual selection
nnoremap <leader>r :% s/\<<c-r><c-w>\>/
xnoremap <leader>r y:% s/<c-r>"/

" Easier buffer switching
nnoremap <leader>l :buffer<space>

" Quit using <c-q>
noremap <silent> <c-q> :q<cr>
inoremap <silent> <c-q> <esc>:q<cr>
cnoremap <silent> <c-q> <esc>:q<cr>

" Mappings for quickfix & location list
nnoremap <silent> ]c :cnext<cr>zz
nnoremap <silent> [c :cprev<cr>zz
nnoremap <silent> ]l :lnext<cr>zz
nnoremap <silent> [l :lprev<cr>zz

" Source a local .vimrc, if available
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
