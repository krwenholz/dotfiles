#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
setxkbmap -layout dvorak
xsetroot -cursor_name left_ptr
xrdb -merge .Xresources
xpmroot ~/background.xpm &

xmonad

