
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


#-------------------------------------------------------------
# Greeting, motd etc...
#-------------------------------------------------------------

### Prompt Colors
GRAY="\033[01;30m"
WHITE="\033[1;37m"
CYAN='\e[1;36m'
RESET="\033[m"

# Git branch details
function parse_git_dirty()  { [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*";  }
function parse_git_branch() { git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"; }

function powerprompt()
{
    symbol="⚡ " # more symbols at http://en.wikipedia.org/wiki/Unicode_symbols
    PS1="\n${GRAY}[ ${CYAN}\u@\h ${GRAY}in ${CYAN}\w${GRAY}$([[ -n $(git branch 2> /dev/null) ]] && echo  on )${CYAN}$(parse_git_branch) ${GRAY}]\n$symbol${RESET}"
    PS2="\n${GRAY}${symbol}${RESET}"
}

powerprompt     # This is the default prompt -- might be slow.

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

alias ll="ls -l --group-directories-first"
alias ls='ls -hF --color'  # add colors for filetype recognition
alias la='ls -Al'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al |more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'

alias vi='vim'
alias sshx='ssh -X'

alias sl='ls'              # typos
alias l='ls'
alias s='ls'
alias mkae='make'
alias maek='make'

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'$*'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe() { find . -type f -iname '*'${1:-}'*' -exec ${2:-file} {} \;  ; }

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
      *.zip)       unzip $1        ;;
      *.Z)         uncompress $1   ;;
      *.7z)        7z x $1         ;;
      *)           echo "'$1' cannot be extracted via >extract<" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

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
export TERMINAL=gnome-terminal

# Set vi mode
# set -o vi
