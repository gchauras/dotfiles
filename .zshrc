# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/Projects/dotfiles/oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="blinks"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  hg
  vi-mode
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
#
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias ll='ls -lG'
alias la='ls -Al'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al |more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'
alias grep='grep   --color=always'    # grep with color
alias egrep='egrep --color=always'
alias fgrep='fgrep --color=always'
alias rgrep='rgrep --color=always'
alias vi='vim'
alias sshx='ssh -X'
alias sl='ls'              # typos
alias l='ls'
alias s='ls'
alias mkae='make'
alias maek='make'
alias cmkae='cmake'
alias cmaek='cmake'

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'$*'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe()
{ find . -type f -iname '*'${1:-}'*' -exec ${2:-file} {} \;  ; }

# Find a pattern in a set of files and highlight them: (needs a recent version of egrep)
function fstr()
{
    OPTIND=1
    local case=""
    local usage="fstr: find string in files.
    Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
            i) case="-i " ;;
        *) echo "$usage"; return;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    find . -type f -name "${2:-*}" -print0 | \
        xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more
}

# Handy Extract Program
function extract()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.rar)       unrar $1        ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Handy open Program for Linux, Mac already has this
if [[ "$OSTYPE" == "linux-gnu" ]]; then
function open()
{
    if [ -f $1 ] ; then
        case $1 in
            *.jpg)      display $1  ;;
            *.png)      display $1  ;;
            *.ppm)      display $1  ;;
            *.pgm)      display $1  ;;
            *.tiff)     display $1  ;;
            *.bmp)      display $1  ;;
            *.pdf)      evince $1   ;;
            *.dvi)      evince $1   ;;
            *.ps)       evince $1   ;;
            *.htm)      firefox $1  ;;
            *.html)     firefox $1  ;;
            *.obj)      meshlab $1  ;;
            *.ply)      meshlab $1  ;;
            *.3ds)      meshlab $1  ;;
        esac
    else
        case $1 in
            *.)         nautilus $1 ;;
            *..)        nautilus $1 ;;
            *./)        nautilus $1 ;;
            *../)       nautilus $1 ;;
            .)          nautilus $1 ;;
            ..)         nautilus $1 ;;
            ./)         nautilus $1 ;;
            ../)        nautilus $1 ;;
            *)          echo "'$1' cannot be opened via >open<" ;;
        esac
    fi
}
fi

# Function to extract pages from a pdf file
function pdfextr()
{
    # $1 is the first page of the range to extract
    # $2 is the last page of the range to extract
    # $3 is the input file
    # output file will be named "inputfile_pXX-pYY.pdf"
    gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
        -dFirstPage=${1} \
        -dLastPage=${2} \
        -sOutputFile=${3%.pdf}_p${1}-p${2}.pdf \
        ${3}
}

function pdfresize()
{
    # $1 is input pdf file
    # $2 is output pdf file
    echo "Resizing $1 to 300dpi for 8.5inx11in paper size"
    gs \
        -o $2 \
        -sDEVICE=pdfwrite \
        -dPDFFitPage \
        -r300x300 \
        -g2550x3300 \
        $1
}

function pdfcombine()
{
    echo "Combining $@ to merged.file.pdf"
    gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=merged.file.pdf $@
}

# spell check
alias spellcheck='aspell -d en_GB -c'
alias spellcheck_tex='aspell -d en_GB -c -t'
alias spellcheckall_tex='find . -name \*.tex -exec aspell -d en_GB -c -t {} \;'

export SVN_EDITOR=vim
export EDITOR=vim

# Mencode options for X264
export MENCODER_X264OPTS="-ovc x264 -x264encopts preset=veryslow:tune=film:crf=15:frameref=15:fast_pskip=0:threads=auto"

# CUDA
export CUDA_INSTALL_PATH=/usr/local/cuda
export CUDA_INC_PATH=$CUDA_INSTALL_PATH/include
export CUDA_LIB_PATH=$CUDA_INSTALL_PATH/lib64
export CUDA_BIN_PATH=$CUDA_INSTALL_PATH/bin
export CUDA_NVVM_BIN_PATH=$CUDA_INSTALL_PATH/nvvm/bin
export CUDA_NVVM_LIB_PATH=$CUDA_INSTALL_PATH/nvvm/lib

export PATH=$CUDA_BIN_PATH:$PATH
export LD_LIBRARY_PATH=$CUDA_BIN_PATH:$CUDA_LIB_PATH:$CUDA_NVVM_BIN_PATH:$CUDA_NVVM_LIB_PATH:$LD_LIBRARY_PATH

export PATH=/usr/local/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib64:/usr/local/lib:$LD_LIBRARY_PATH

export TEXLIVE=/usr/local/texlive/2016/bin/x86_64-darwin/
export PATH=$TEXLIVE:$PATH

export QT_DIR=$HOME/Software/Qt/5.7/clang_64
export QT_BIN_DIR=$QT_DIR/bin
export Qt5_DIR=$QT_DIR/lib/cmake/Qt5
export Qt5OpenGL_DIR=$QT_DIR/lib/cmake/Qt5OpenGL
export PATH=$QT_BIN_PATH:$PATH
