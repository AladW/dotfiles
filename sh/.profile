export LESSHISTFILE=/dev/null
export MC_KEYMAP=mc.emacs.keymap
export QUOTING_STYLE=literal

if ! [ "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
	exec startx
fi
