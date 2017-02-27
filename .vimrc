" Configuration file for vim

set encoding=utf-8
set nocompatible	" Vim defaults instead of 100% vi compatibility

" -----------------------------------------------------------------------------
" enable Doxygen syntax
let g:load_doxygen_syntax=1

" -----------------------------------------------------------------------------
" File types
au BufNewFile,BufRead *.cpp set filetype=cpp       " C++ source file
au BufNewFile,BufRead *.cc  set filetype=cpp       " C++ source file
au BufNewFile,BufRead *.cxx set filetype=cpp       " C++ source file
au BufNewFile,BufRead *.hpp set filetype=cpp       " C++ source file
au BufNewFile,BufRead *.h   set filetype=cpp       " C++ source file
au BufNewFile,BufRead *.hh  set filetype=cpp       " C++ source file
au BufNewFile,BufRead *.hxx set filetype=cpp       " C++ source file
au BufNewFile,BufRead *.vp  set filetype=cpp       " C++ source file
au BufNewFile,BufRead *.gp  set filetype=cpp       " geometry shaders as C source file
au BufNewFile,BufRead *.fp  set filetype=cpp       " pixel shaders as C source file
au BufNewFile,BufRead *.cl  set filetype=cpp       " OpenCL as C source file
au BufNewFile,BufRead *.cu  set filetype=cpp       " CUDA as C source file
au BufNewFile,BufRead *.md  set filetype=markdown  " markdown files
au BufNewFile,BufRead *.py  set filetype=python    " python files

" -----------------------------------------------------------------------------
" Plugins using vundle

filetype off                                " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'               " let vundle manage vundle
Plugin 'altercation/vim-colors-solarized'   " solarized color scheme
Plugin 'tpope/vim-fugitive'                 " git management
Plugin 'tpope/vim-markdown'                 " markdown syntax
Plugin 'Valloric/YouCompleteMe'             " code completion -- Jedi for python
Plugin 'scrooloose/syntastic'               " python syntax checking
Plugin 'nvie/vim-flake8'                    " python PEP8 checking
Plugin 'vim-scripts/indentpython.vim'       " python indentation
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
call vundle#end()

" -----------------------------------------------------------------------------
" Syntax highlighting
syntax on                   " enable syntax highlighting
" filetype plugin on          " load filetype plugins/indent settings
filetype plugin indent on   " load filetype plugins/indent settings

" -----------------------------------------------------------------------------
" Code completion
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" -----------------------------------------------------------------------------
" PEP8 settings for python
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

" Mark bad whitespace for python
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" -----------------------------------------------------------------------------

set modelines=0		" CVE-2007-2438
set backspace=2		" more powerful backspacing

set completeopt=
set expandtab
set formatoptions=rq
set ignorecase
set infercase
set wrap
" set shiftround
set smartcase
set shiftwidth=4
set softtabstop=4
set tabstop=4
set nu

set autochdir                   " always switch to the current file directory
set backspace=indent,eol,start  " make backspace a more flexible

set clipboard+=unnamed          " share windows clipboard
set fileformats=unix,dos,mac
" set hidden

set iskeyword+=_,$,@,%,#        " none of these are word dividers
set mouse=a                     " use mouse everywhere
set whichwrap=b,s,h,l,<,>,~,[,] " everything wraps

set wildmenu                " turn on command line completion wild style
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
set wildmode=list:longest     " turn on wild mode huge list

set cursorcolumn          " highlight the current column
set cursorline            " highlight current line

set lazyredraw              " do not redraw while running macros
set linespace=0             " don't insert any extra pixel lines
set listchars=tab:>-,trail:- " show tabs and trailing

set matchtime=5             " how many tenths of a second to blink
set nostartofline           " leave my cursor where it was

set re=1

set noerrorbells            " don't make noise
set novisualbell            " don't blink
au  VimEnter * set vb t_vb=

set number                  " turn on line numbers
set numberwidth=4           " We are good up to 99999 lines
set report=0                " tell us when anything is changed via :...
set ruler                   " Always show current positions along the bottom
set scrolloff=10            " Keep 10 lines (top/bottom) for scope
set shortmess=aOstT         " shortens messages to avoid

set showcmd                 " show the command being typed
set showmatch               " show matching brackets
set sidescrolloff=10        " Keep 5 lines at the size

set foldmethod=syntax       " fold based on indent
set foldnestmax=5           " deepest fold is 10 levels
set nofoldenable            " dont fold by default
set foldlevel=1             " this is just what i use
set hlsearch                " highlight the last searched term
set incsearch               " BUT do highlight as you type you
" set ai                      " auto indenting

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif |
\ endif

" -----------------------------------------------------------------------------
" Powerline setup
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

" -----------------------------------------------------------------------------
" Detect and remove trailing whitespace
au BufWritePre * :%s/\s\+$//e           "remove trailing spaces
au FileType c,cpp,java,php,py,html autocmd BufWritePre <buffer> :%s/\s\+$//e

function ShowAllSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimAllSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowAllSpaces call ShowAllSpaces(<args>)
command -bar -nargs=0 -range=% TrimAllSpaces <line1>,<line2>call TrimAllSpaces()

" -----------------------------------------------------------------------------
" Setting up the undo/history
set history=1000
set undolevels=1000             " maximum number of changes that can be undone
set nobackup                    " no backup or swap files
set nowritebackup
set noswapfile

" -----------------------------------------------------------------------------
" Color scheme
set background=dark
set t_Co=16
colorscheme solarized
