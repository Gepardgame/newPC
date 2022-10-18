# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#Set the default Editor to vim
export EDITOR="vim"
set -o vi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend


# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
HISTTIMEFORMAT="%F %T "
HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#Some Colors
schwarz="\e[30m"
weis="\e[97m"

#dunkele Farben
d_blau="\e[34m"
d_gruen="\e[32m"
d_aqua="\e[36m"
d_rot="\e[31m"
d_lila="\e[35m"
d_gelb="\e[33m"
d_grau="\e[90m"

#helle Farben
h_grau="\e[37m"
h_blau="\e[94 "
h_gruen="\e[92m"
h_aqua="\e[96m"
h_rot="\e[91m"
h_lila="\e[95m"
h_gelb="\e[93m"

#dunklere Hintergrundfarbe
b_schwarz="\e[40m"
b_rot="\e[41m"
b_gruen="\e[42m"
b_orange="\e[43m"
b_blau="\e[44m"
b_lila="\e[45m"
b_aqua="\e[46m"
b_grau="\e[100m"

#heller Hintergrundfarbe
b_h_grau="\e[47m"
b_h_rot="\e[101m"
b_h_gruen="\e[102m"
b_gelb="\e[103m"
b_h_blau="\e[104m"
b_h_lila="\e[105m"
b_h_aqua="\e[106m"
b_weis="\e[107m"

#Besonderheiten
normal="\e[0m"
fett="\e[1m"
kursiv="\e[3m"
durchgestrichen="\e[9m"

#Linuxbesonderheiten
reverse="\e[7m"
blinken="\e[5m"
versteckt="\e[8m"

function git_branch() {
    if [ -d .git ] ; then
        printf ${h_aqua}" %s " "($(git branch 2> /dev/null | awk '/\*/{print $2}'))";
    fi
}

function GetMergeAndRebaseConflict() {
  local g="$(git rev-parse --git-dir 2>/dev/null)"
  local r
  local b
  if [ -n "$g" ]; then
    if [ -d "$g/rebase-apply" ]
    then
      if test -f "$g/rebase-apply/rebasing"
      then
        r="|REBASE"
	printf ${d_rot}${r}
      elif test -f "$g/rebase-apply/applying"
      then
        r="|AM"
	printf ${d_rot}${r}
      else
        r="|AM/REBASE"
	printf ${d_rot}${r}
      fi
      b="$(git symbolic-ref HEAD 2>/dev/null)"
    elif [ -f "$g/rebase-merge/interactive" ]
    then
      r="|REBASE-i"
      b="$(cat "$g/rebase-merge/head-name")"
      printf ${d_rot}${r}
    elif [ -d "$g/rebase-merge" ]
    then
      r="|REBASE-m"
      b="$(cat "$g/rebase-merge/head-name")"
      printf ${d_rot}${r}
    elif [ -f "$g/MERGE_HEAD" ]
    then
      r="|MERGING"
      b="$(git symbolic-ref HEAD 2>/dev/null)"
      printf ${d_rot}${r}
    fi
   ## printf ${d_rot}${r}
  fi
##  printf ${d_rot}${r}
}



if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}'${h_gruen}${fett}'[\u@\h]'${normal}': '${d_rot}'\w$(git_branch)'${normal}'$(GetMergeAndRebaseConflict)'${normal}'\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}'${d_rot}'\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias l='ls -lat'
alias apt='apt -y'
alias aptitude='aptitude -y'
alias echo='echo -e'
alias c='clear'
alias cl='c && l'


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[ -f /usr/local/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.bash ] && . /usr/local/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.bash

#Own funktions
function hg() {
    history | grep "$1";
}
