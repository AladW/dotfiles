#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'
alias ix="curl -F 'f:1=<-' ix.io"
alias sprunge="curl -F 'sprunge=<-' sprunge.us"
alias ls='ls --color=auto'
alias mc='. /usr/lib/mc/mc-wrapper.sh -x'
PS1='[\u@\h \W]\$ '

# ssh agent
eval "$(keychain --quiet --quick --eval)"

# fuzzy matching
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# avoid losing shell history
HISTFILESIZE=400000000
HISTSIZE=10000
PROMPT_COMMAND="history -a"
shopt -s histappend

# shell-specific environment variables
export AUR_REPO=alad
export AUR_DBROOT=/var/cache/pacman/custom/alad
export EDITOR=vim
export VISUAL=vim
