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

# environment variables (qt5)
#if [ -f /usr/lib/qt/plugins/platformthemes/libqgtk2.so ]; then
#    export QT_QPA_PLATFORMTHEME=gtk2
#elif [ -f usr/lib/qt/plugins/platformthemes/libqt5ct.so ]; then
#    export QT_QPA_PLATOFRMTHEME=qt5ct
#fi

# run desktop files
dex --autostart --environment XFCE &

# mouse settings
xfconf-query -c xsettings -p /Gtk/CursorThemeSize -s 16
xfconf-query -c xsettings -p /Gtk/CursorThemeName -s Adwaita

# keyboard settings
xfconf-query -c keyboard-layout -p /Default/XkbLayout -s gb
xfconf-query -c keyboard-layout -p /Default/XkbVariant -s extd

# acpi events
if ! pgrep -u $UID uacpid; then
    uacpid --opendisplay &
fi

# window manager
exec i3
