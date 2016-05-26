if [ -f /etc/bashrc ]; then
    . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi

# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob        # Necessary for programmable completion.

export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTTIMEFORMAT="%H:%M > "
export HISTIGNORE="&:bg:fg:ll:h"
export HOSTFILE=$HOME/.hosts    # Put list of remote hosts in ~/.hosts ...

function powerprompt()
{
    CYAN='\e[0;36m'     # Cyan
    NC='\e[0m'          # No Color

    # Get the git prompt script
    GIT_PROMPT_ONLY_IN_REPO=0
    GIT_PROMPT_START="\n${CYAN}[\u@\h \w]${NC}"
    GIT_PROMPT_END="\n$ "
    GIT_PROMPT_FETCH_REMOTE_STATUS=1    # uncomment to avoid fetching remote status
    GIT_PROMPT_SHOW_UPSTREAM=1          # uncomment to show upstream tracking branch
    GIT_PROMPT_SHOW_UNTRACKED_FILES=all # can be no, normal or all
    GIT_PROMPT_THEME=Solarized          # use theme optimized for solarized color scheme
    source $HOME/Projects/dotfiles/bash-git-prompt/gitprompt.sh
}

powerprompt     # This is the default prompt -- might be slow.

# Colors for filetype recognition with ls
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    alias ls='ls -hFG --color'
    DIRCOLORS_FILE=$HOME/.dircolors
    if [ -f $DIRCOLORS_FILE ]; then
        eval `dircolors $DIRCOLORS_FILE`
    else
        export LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
    fi
else
    # Mac and other platforms
    alias ls='ls -hFG'
    export LSCOLORS=dxfxcxdxbxegedabagacad
fi

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

alias spellcheck='aspell --lang=en_US -c'

function spellcheck_tex()
{
    #1 is the input tex file
    aspell --lang=en_US -t -c $1;
}

function spellcheckall_tex()
{
    find . -name \*.tex -exec aspell --lang=en_US -t -c {} \;
}

export SVN_EDITOR=vim
export EDITOR=vim

export CUDA_INSTALL_PATH=/usr/local/cuda
export CUDA_INC_PATH=$CUDA_INSTALL_PATH/include
export CUDA_LIB_PATH=$CUDA_INSTALL_PATH/lib64
export CUDA_BIN_PATH=$CUDA_INSTALL_PATH/bin

export PATH=$CUDA_BIN_PATH:$PATH
export LD_LIBRARY_PATH=$CUDA_BIN_PATH:$CUDA_LIB_PATH:$LD_LIBRARY_PATH

export PATH=/usr/local/:$PATH
