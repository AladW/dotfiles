#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if ! [[ $DISPLAY ]] && [[ $XDG_VTNR == 1 ]]; then
	exec startx
fi
