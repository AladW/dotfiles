#!/bin/sh
userresources=$HOME/.Xresources

# merge in defaults and keymaps
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# launches a session dbus instance
if [ -z "${DBUS_SESSION_BUS_ADDRESS-}" ] && type dbus-launch >/dev/null; then
    eval $(dbus-launch --sh-syntax --exit-with-session)
fi

# environment variables
export COLORTERM=truecolor
export NO_AT_BRIDGE=1
export GTK_OVERLAY_SCROLLING=0
export XDG_CURRENT_DESKTOP=X-Generic

# environment variables (qt5)
if [ -f /usr/lib/qt/plugins/platformthemes/libqgtk2.so ]; then
   export QT_QPA_PLATFORMTHEME=gtk2
elif [ -f usr/lib/qt/plugins/platformthemes/libqt5ct.so ]; then
   export QT_QPA_PLATOFRMTHEME=qt5ct
fi

#0 autostart (xdg)
dex -a --environment MATE &

#1 settings to X11 applications
xsettingsd &

#2 keyboard settings
setxkbmap -layout gb -variant extd

#3 removable media
udiskie -AFs &

#4 screen locker
xset s 600 420
xss-lock -n x-dim-screen -l -- x-screenlocker &

#5 compositing manager
compton --config /dev/null --backend glx --vsync &

#6 window manager
exec i3
