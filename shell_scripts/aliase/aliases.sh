#!/bin/bash
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

alias ll='ls -l'
alias la='ls -A'
alias l='ls -halt'
alias echo='echo -e'
alias c='clear'
alias cl='c && l'
alias wbash='vim ~/.bashrc'
alias rbash='source ~/.bashrc'
alias p="python"
alias i="ipython3"
alias clone="git clone --recurse-submodules"
alias hg="history | grep "
alias bootlog="sudo cat /var/log/boot.log|more"
alias gping="nmap -sn"
alias copy="xsel --input --clipboard"
alias past="xsel --output --clipboard"
#alias gitcreateproject="git push --set-upstream git@mygit.th-deg.de:ts19084/$(git rev-parse --show-toplevel | xargs basename).git $(git rev-parse --abbrev-ref HEAD)"

# Variables
export wlan=wlp2s0
export eth=enp1s0f0
