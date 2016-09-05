" Deactivate vi compatibility
set nocompatible

" Disable unused built-in plugins
let g:loaded_2html_plugin=1
let g:loaded_getscriptPlugin=1
let g:loaded_netrwPlugin=1
let g:loaded_vimballPlugin=1

" Set UTF-8 as the default encoding
set encoding=utf-8
set termencoding=utf-8
setglobal fileencoding=utf-8

" Disable modeline
set nomodeline

" Activate the mouse (wheel, selection, etc...)
set mouse=a

" Hide the mouse when typing
set mousehide

" Automatically switch to the directory of the current file
set autochdir

" Reload current file after each modification
set autoread

" Automatically save buffer before :next, :make etc...
"set autowrite

" Ask to save modified files before operations like :q
"set confirm

" Better display in terminal mode
set ttyfast

" Don't redraw when running macros
set lazyredraw

" Allow more than one unsaved buffer
set hidden

" Enhanced command-line completion
set wildmenu

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
function! s:mkdir(path)
  if exists('*mkdir') && !isdirectory(a:path)
    call mkdir(a:path)
  endif
endfunction
call s:mkdir($HOME.'/.vim/tmp')
call s:mkdir($HOME.'/.vim/tmp/swap')
call s:mkdir($HOME.'/.vim/tmp/undo')
call s:mkdir($HOME.'/.vim/tmp/info')
call s:mkdir($HOME.'/.vim/tmp/backup')
set backupdir=$HOME/.vim/tmp/backup/
set directory=$HOME/.vim/tmp/swap//
set undodir=$HOME/.vim/tmp/undo/
set viminfo='100,n$HOME/.vim/tmp/info/viminfo

" Set the window title
set title
set titlestring=%F\ %m

" Don't display the intro message when starting
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

" Don't wrap long lines
set nowrap

" Add a ↪ at the start of lines that have been wrapped
"let &showbreak='↪ '

" Only wrap at a character in the 'breakat' option
"set linebreak

" Show as much as possible of the last line
set display+=lastline

" Highlight matching brackets
set showmatch
set matchtime=1

" Disable folding
set nofoldenable

" Fold using indentation
"set fdm=indent

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

" More powerful backspacing (allows backspacing over everything in insert mode)
set backspace=indent,eol,start

" Allow <left>/<right> and h/l to wrap the cursor around line borders
set whichwrap=<,>,h,l

" Allow the cursor to go after the end of line
set virtualedit=onemore,block

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

" Don't show possible completions that don't match the case of existing text
set infercase

" Don't show more than 10 items in the popup menu
set pumheight=10

" Delete comment character when joining commented lines
set formatoptions+=j

" Use system's default clipboards for yanking/pasting
if has('unnamedplus')
  set clipboard=unnamedplus
endif
set clipboard+=unnamed

" Case insensitive search
set ignorecase

" Smart case sensitivity (has priority over ignorecase)
set smartcase

" Activate incremental searching
set incsearch

" Don't highlight search results
set nohlsearch

" Load plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
source $HOME/.vim/plugins.vim

" Activate filetype-specific indenting, syntax highlighting, etc...
filetype plugin indent on

" Activate syntax highlighting
syntax on

" Finer-grained undo
inoremap <silent> <tab> <tab><c-g>u
inoremap <silent> <space> <space><c-g>u
inoremap <silent> <return> <return><c-g>u

" Make <up>/<down> move by virtual lines in insert mode
"inoremap <up> <c-o>gk
"inoremap <down> <c-o>gj

" Make j/k/<up>/<down> move by physical lines when used with a count and by virtual lines when used without
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

" Don't lose selection when shifting sidewards
xnoremap <silent> < <gv
xnoremap <silent> > >gv

" \s sorts the current visual selection
xnoremap <silent> <leader>s :sort<cr>

" \h toggles search results highlighting
nnoremap <silent> <leader>h :setlocal hlsearch!<cr>

" \<space> toggles spell-checking
nnoremap <silent> <leader><space> :setlocal spell!<cr>

" Easily replace the word under the cursor
nnoremap <leader>r :% s/\<<c-r><c-w>\>/
vnoremap <leader>r y:% s/<c-r>"/

" Easier buffer switching
nnoremap <leader>l :buffer<space>
inoremap <leader>l <c-o>:buffer<space>
