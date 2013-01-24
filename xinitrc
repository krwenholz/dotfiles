#!/bin/sh
#
# ~/.xinitrc
#

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Executed by startx (run your window manager from here)
xrdb -merge ~/.Xresources
setxkbmap -layout dvorak
setxkbmap -option 'ctrl:swapcaps'

# Some background stuff
fbsetbg /home/krwenholz/Pictures/Background/asimplecleanplace.png

xcompmgr -c &

# Sets the trackpad to deactivate for typing
syndaemon -t -k -i 2 -d &

# Now launch my window manager.
#exec ck-launch-session dbus-launch startfluxbox
exec dbus-launch startfluxbox
#exec startlxde

# Notifications on screen
#/usr/lib/notification-daemon-1.0/notification-daemon &
