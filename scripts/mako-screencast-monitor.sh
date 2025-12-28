#!/bin/bash

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

socat -U - UNIX-CONNECT:"$SOCKET" | while read -r line; do
	case "$line" in
	screencast\>\>1,*) makoctl mode -a do-not-disturb ;;
	screencast\>\>0,*) makoctl mode -r do-not-disturb ;;
	esac
done
