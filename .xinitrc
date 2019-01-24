#!/bin/bash

[ -f ~/.Xresources ] && rxdb -merge ~/.Xresources

xset r rate 250 25

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

exec i3

# Set background picture
feh ~/.config/wallpaper.jpg --bg-fill

