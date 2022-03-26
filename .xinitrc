#!/bin/bash

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

SESSION=${1:-xfce-session}

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

get_session(){
	local dbus_args=(--sh-syntax --exit-with-session)
	case "$1" in
		awesome) dbus_args+=(awesome) ;;
		bspwm) dbus_args+=(bspwm-session) ;;
		budgie) dbus_args+=(budgie-desktop) ;;
		cinnamon) dbus_args+=(cinnamon-session) ;;
		deepin) dbus_args+=(startdde) ;;
		enlightenment) dbus_args+=(enlightenment_start) ;;
		fluxbox) dbus_args+=(startfluxbox) ;;
		gnome) dbus_args+=(gnome-session) ;;
		i3|i3wm) dbus_args+=(i3 --shmlog-size 0) ;;
		jwm) dbus_args+=(jwm) ;;
		kde) dbus_args+=(startplasma-x11) ;;
		lxde) dbus_args+=(startlxde) ;;
		lxqt) dbus_args+=(lxqt-session) ;;
		mate) dbus_args+=(mate-session) ;;
		xfce) dbus_args+=(xfce4-session) ;;
		openbox) dbus_args+=(openbox-session) ;;
		*) dbus_args+=("$1") ;;
	esac

	echo "dbus-launch ${dbus_args[*]}"
}

exec $(get_session "$1")

## Export locale variables
# I use autox for Display Manager replacement
# It has a bug that make locale configurations are not loaded on login
# (Confirmed in Void Wiki)
# So I export the locale configurations manually
# Without this some character in terminal couldn't be loaded
export LANG=en_GB.utf8
export LC_COLLATE=C
export LC_ADDRESS=en_GB.utf8
export LC_CTYPE=en_GB.utf8
export LC_IDENTIFICATION=en_GB.utf8
export LC_MEASUREMENT=id_ID.utf8
export LC_MESSAGES=en_GB.utf8
export LC_MONETARY=id_ID.utf8
export LC_NAME=en_GB.utf8
export LC_NUMERIC=id_ID.utf8
export LC_PAPER=en_GB.utf8
export LC_TELEPHONE=id_ID.utf8
export LC_TIME=en_GB.utf8



## Launch Bspwm
# All other autostarts live in bspwmrc
exec bspwm

# xset +fp /usr/share/fonts/TTF
