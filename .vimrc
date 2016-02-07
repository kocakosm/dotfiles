" Deactivate vi compatibility
set nocompatible

" Set UTF-8 as the default encoding
set encoding=utf-8

" Activate the mouse (wheel, selection, etc...)
set mouse=a

" Always change to the directory of the current file
set autochdir

" Reload the file after each modification
set autoread

" Better display in terminal mode
set ttyfast

" Don't redraw when running macros
set lazyredraw

" Allow switching from an unsaved buffer (without saving it first)
"set hidden

" Enhance command-line completion
set wildmenu

" Don't try to open these
set wildignore+=.hg,.git,.svn
set wildignore+=*.png,*.jpg,*.jpeg,*.gif
set wildignore+=*.o,*.pyc,*.pyo,*.class
set wildignore+=*.aux,*.log,*.dvi,*.bbl,*.blg,*.out,*.toc
set wildignore+=*.orig

" Don't create the ~/.vim/.netrwhist file
let g:netrw_dirhistmax=0

" Don't keep backup
set nobackup
set nowritebackup

" Don't create swap file
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

" Window title
set title
set titlestring=%F\ %m

" Display commands as they are typed
set showcmd

" Show the current mode
set showmode

" Always show the status line
"set laststatus=2

" Show the cursor position
set ruler

" Show line numbers
set number

" Use 4 columns for line numbers
set numberwidth=4

" Open new windows below the current window
set splitbelow

" Open new windows right of the current window
set splitright

" Line spacing
set linespace=3

" Maximum text width (0 means don't cut lines)
set textwidth=0

" Don't wrap long lines
set nowrap

" Only wrap at a character in the breakat option
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

" Show folding marks (left margin)
"set foldcolumn=1

" Try to keep 1 line above and below the cursor
set scrolloff=1

" Side-scroll 5 chars before the screen border
set sidescrolloff=5

" Prevent the cursor from changing the current column when jumping to other lines
set nostartofline

" Show tabs, non-printable characters, ...
set list
let &listchars='tab:┊ '
"let &listchars='tab:▸ ,extends:❯,precedes:❮,trail:·,eol:¬'
"let &showbreak='↪ '

" Activate syntaxic coloration
syntax on

" Colorscheme for the terminal mode
"colorscheme default

" Highlight lines longer than 80 characters
"highlight link OverLength ErrorMsg
"match OverLength /\%81v.\+/
"setlocal colorcolumn=81

" More powerful backspacing (allows backspacing over everything in insert mode)
set backspace=indent,eol,start

" Allow left/right keys and h/l commands to wrap the cursor around line borders
set whichwrap=<,>,h,l

" Allow the cursor to go after the end of line
set virtualedit=onemore,block

" Smart automatic indentation
set autoindent
set smartindent

" Don't replace tabulations with white spaces
set noexpandtab

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

" Use the * register for the clipboard
set clipboard^=unnamed

" Case insensitive search
set ignorecase

" Smart case sensitivity (has priority over ignorecase)
set smartcase

" Activate incremental searching
set incsearch

" Don't highlight search results
set nohlsearch

" Load plugins
source $HOME/.vim/plugins.vim

" Load matchit
if !exists('g:loaded_matchit')
  runtime macros/matchit.vim
endif

" Activate the file type plugins
filetype plugin indent on

" Remove trailing white spaces before saving
autocmd BufWrite * silent! %s/[\r \t]\+$//

" Source vimrc when saved
"autocmd BufWritePost $MYVIMRC source $MYVIMRC

" Move between screen lines instead of real lines
"noremap <Up> gk
"noremap <Down> gj
"inoremap <Up> <C-o>gk
"inoremap <Down> <C-o>gj

" Y yanks from the cursor to the end of the line
noremap Y y$

" Let space and backspace act the same way as in insert mode
"noremap <silent> <Space> i<Space><Right><Esc>
"noremap <silent> <Backspace> i<Backspace><Right><Esc>

" Ctrl-t opens a new tab
"noremap <silent> <C-t> :tabnew<CR>
"inoremap <silent> <C-t> <C-o>:tabnew<CR>

" Use tabulation to go to the next tab
"noremap <Tab> gt

" Alt-Right switches to the next buffer
noremap <silent> <A-RIGHT> :bn!<CR>
inoremap <silent> <A-RIGHT> <C-o>:bn!<CR>

" Alt-Left switches to the previous buffer
noremap <silent> <A-LEFT> :bp!<CR>
inoremap <silent> <A-LEFT> <C-o>:bp!<CR>

" Finer-grained undo
inoremap <Tab> <Tab><C-g>u
inoremap <Space> <Space><C-g>u
inoremap <Return> <Return><C-g>u

" Don't lose selection when shifting sidewards
xnoremap < <gv
xnoremap > >gv

" Search for selected text using '/'
vnoremap <silent> / :<C-U>
\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
\gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
\gV:call setreg('"', old_reg, old_regtype)<CR>
