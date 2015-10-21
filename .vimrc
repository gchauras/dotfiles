" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
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
set nobackup
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

" set cursorcolumn          " highlight the current column
" set cursorline            " highlight current line

set lazyredraw              " do not redraw while running macros
set linespace=0             " don't insert any extra pixel lines
set listchars=tab:>-,trail:- " show tabs and trailing

set matchtime=5             " how many tenths of a second to blink
set nostartofline           " leave my cursor where it was

set re=1

set noerrorbells            " don't make noise
set novisualbell            " don't blink
autocmd VimEnter * set vb t_vb=

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

set ai                      " auto indenting
set history=100             " keep 100 lines of history
set ruler                   " show the cursor position

syntax on                   " enable syntax highlighting
filetype plugin on          " load filetype plugins/indent settings
filetype plugin indent on   " load filetype plugins/indent settings

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif |
\ endif

" -----------------------------------------------------------------------------
" enable Doxygen syntax
let g:load_doxygen_syntax=1

" -----------------------------------------------------------------------------
" New file types
au BufNewFile,BufRead *.vp set filetype=cpp "use vertex shaders as C source file
au BufNewFile,BufRead *.gp set filetype=cpp "use geometry shaders as C source file
au BufNewFile,BufRead *.fp set filetype=cpp "use pixel shaders as C source file
au BufNewFile,BufRead *.cl set filetype=cpp "use OpenCL as C source file
au BufNewFile,BufRead *.cu set filetype=cpp "use CUDA as C source file

" -----------------------------------------------------------------------------
" Status line quirks
hi statusline ctermfg=DarkGreen ctermbg=Black   " default
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline ctermfg=DarkGreen ctermbg=Black
  elseif a:mode == 'r'
    hi statusline ctermfg=DarkGreen ctermbg=Black
  else
    hi statusline ctermfg=DarkGreen ctermbg=Black
  endif
endfunction
au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline ctermfg=DarkGreen ctermbg=Black
set statusline=%f                               " file name
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, " file encoding
set statusline+=%{&ff}]                         " file format
set statusline+=%y                              " filetype
set statusline+=%h                              " help file flag
set statusline+=%m                              " modified flag
set statusline+=%r                              " read only flag
set statusline+=\ %=                            " align left
set statusline+=Line:%l/%L[%p%%]                " line X of Y [percent of file]
set statusline+=\ Col:%c                        " current column
set statusline+=\ Buf:%n                        " buffer number

" -----------------------------------------------------------------------------
" Detect and remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e           "remove traliling spaces
autocmd FileType c,cpp,java,php,html autocmd BufWritePre <buffer> :%s/\s\+$//e

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

" Setting up the undo/history
set history=1000
set undolevels=1000             " maximum number of changes that can be undone
set nobackup                    " seriously, use a VCS
set nowritebackup
set noswapfile                  " they are really annoying...

" Color scheme
set background=dark
set t_Co=16
colorscheme solarized
