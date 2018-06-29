#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap


# merge in defaults and keymaps

if [ -f "$sysresources" ]; then
    xrdb -merge "$sysresources"
fi

if [ -f "$sysmodmap" ]; then
    xmodmap "$sysmodmap"
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xautolock -detectsleep \
    -time 9 -notify 20 \
    -notifier "notify-send -t 18000 -u critical 'Lock' 'Locking screen in 20 seconds.'" \
    -locker /usr/local/bin/lock &

amixer -c PCH set "Master" mute &
amixer -c PCH cset 'name=Headphone Mic Boost Volume' 1 &

setxkbmap -option caps:escape &

redshift -c .config/redshift/redshift.conf &

compton --config .config/compton.conf &

udiskie &

# Window Manager
exec awesome
