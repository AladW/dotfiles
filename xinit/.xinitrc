#!/bin/sh
userresources=$HOME/.Xresources

# merge in defaults and keymaps
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# 50-systemd-user.sh
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
export XDG_CURRENT_DESKTOP=XFCE

# environment variables (qt5)
if [ -f /usr/lib/qt/plugins/platformthemes/libqgtk2.so ]; then
   export QT_QPA_PLATFORMTHEME=gtk2
elif [ -f /usr/lib/qt/plugins/platformthemes/libqt5ct.so ]; then
   export QT_QPA_PLATFORMTHEME=qt5ct
fi

setxkbmap -layout gb -variant extd
exec i3
