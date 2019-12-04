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
export NO_AT_BRIDGE=1
export GTK_OVERLAY_SCROLLING=0
export XDG_CURRENT_DESKTOP=X-Generic

# environment variables (qt5)
if [ -f /usr/lib/qt/plugins/platformthemes/libqgtk2.so ]; then
   export QT_QPA_PLATFORMTHEME=gtk2
elif [ -f /usr/lib/qt/plugins/platformthemes/libqt5ct.so ]; then
   export QT_QPA_PLATFORMTHEME=qt5ct
fi

# autostart (xdg)
dex -a blueman.desktop
dex -a gnome-keyring-secrets.desktop
dex -a nm-applet.desktop
dex -a polkit-mate-authentication-agent-1.desktop
dex -a xfsettingsd.desktop

#1 disable PC speaker
xset -b

#2 keyboard settings
setxkbmap -layout gb -variant extd

#3 removable media
udiskie -AFs &

#4 screen locker
xss-lock -l -- x-screenlocker &

#5 multimedia keys
uacpid --opendisplay --tty &

# window manager
exec i3
