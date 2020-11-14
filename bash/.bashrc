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

# git prompt
if [[ -f /usr/share/git/completion/git-prompt.sh ]]; then
    source /usr/share/git/completion/git-prompt.sh
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWCOLORHINTS=1

    PROMPT_COMMAND+=';__git_ps1 "\u@\h:\w" "\\\$ "'
    #PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
fi

# shell-specific environment variables
export EDITOR=vim
export VISUAL=vim

# aurutils
export AUR_REPO=custom
export AUR_DBROOT=/home/custompkgs
export AUR_QUERY_PARALLEL=1
export AUR_QUERY_PARALLEL_MAX=10
