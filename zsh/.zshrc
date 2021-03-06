# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _match _approximate _prefix
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list '+m:{[:lower:]}={[:upper:]} r:|[._-]=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt '%e'
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/archie/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt append_history nomatch autocd prompt_subst
bindkey -e
# End of lines configured by zsh-newuser-install

# Freeze terminal state
ttyctl -f

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

bindkey ';5D' emacs-backward-word
bindkey ';5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word
bindkey '^[[1;5C' emacs-forward-word

#Prompt
autoload -Uz colors && colors

fg_alert=%{$'\e[38;5;161m'%}
at_normal=%{$'\e[0m'%}

function virtualenv_info {
    [[ $VIRTUAL_ENV ]] && echo "[ %{$fg[magenta]%}virt:%{$reset_color%} "$(basename $VIRTUAL_ENV)" ] "
}

PROMPT='%{$fg_bold[yellow]%}%n%{$reset_color%}@%{$fg_bold[cyan]%}%m %{$fg_bold[blue]%}%4~%{$reset_color%} $(virtualenv_info)%# '
#RPROMPT="%* [%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

case $TERM in
    termite|*xterm*|rxvt*|(dt|k|E)term|st*)
        function precmd {
            print -Pn "\e]0;[%n@%M][%~]%#\a"
        }

        function preexec {
            print -Pn "\e]0;[%n@%M][%~]%# ($1)\a"
        }
        ;;
    screen*|tmux*)
        function precmd { 
            print -Pn "\e]83;title \"$1\"\a" 
            print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a" 
        }

        function preexec { 
            print -Pn "\e]83;title \"$1\"\a" 
            print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a" 
        }
        ;; 
esac

function man {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# fuzzy matching
if [[ -f /usr/share/fzf/completions.zsh ]]; then
    source /usr/share/fzf/completions.zsh
fi
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh
fi

# ssh keys
if command -V keychain >/dev/null; then
    eval "$(keychain --quiet --quick --eval)"
fi

# misc
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias mc='. /usr/lib/mc/mc-wrapper.sh -x'
bl() { if [[ $1 ]]; then
    xbacklight -set "$1"
else
    xbacklight -get
fi
}

# shell-specific variables
export EDITOR=vim
export VISUAL=vim

# aurutils
export AUR_REPO=custom
export AUR_DBROOT=/home/custompkgs
export AUR_QUERY_PARALLEL=1
export AUR_QUERY_PARALLEL_MAX=10
