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
setxkbmap -layout dvorak
setxkbmap -option 'ctrl:swapcaps'

# Mouse settings!
synclient FingerHigh=50
synclient RTCornerButton=0
synclient LTCornerButton=0
synclient RBCornerButton=0
synclient LBCornerButton=0
synclient MinSpeed=0.7
synclient MaxSpeed=1.7
synclient TapAndDragGesture=off
synclient PalmDetect=on
synclient VertScrollDelta=-71
synclient HorizScrollDelta=-71

# Now launch my window manager.
exec ck-launch-session gnome-session
startx
