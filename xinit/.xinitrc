#!/bin/sh
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# input method
export GTK_IM_MODULE=xim
export XMODIFIERS=@im=xim
export QT_IM_MODULE=xim

# gtk3
export NO_AT_BRIDGE=1
export GTK_OVERLAY_SCROLLING=0

# qt5
if [ -f /usr/lib/qt/plugins/platformthemes/libqgtk2.so ]; then
    export QT_QPA_PLATFORMTHEME=gtk2
elif [ -f usr/lib/qt/plugins/platformthemes/libqt5ct.so ]; then
    export QT_QPA_PLATOFRMTHEME=qt5ct
fi

# run desktop files
dex --autostart --environment XFCE &
# keyboard settings
setxkbmap -layout gb -variant intl
# acpi events
uacpid --opendisplay &
# compositing manager
compton --no-fading-openclose &
# wallpaper
"$HOME"/.fehbg &
# window manager
exec i3
