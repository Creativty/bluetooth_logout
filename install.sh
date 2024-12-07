#!/usr/bin/env bash

NAME_SCRIPT="logout_monitor.sh"
PATH_INSTALL="$(realpath -s $0)"
PATH_AUTOSTART="$HOME/.config/autostart"
PATH_REPOSITORY="$(dirname $PATH_INSTALL)"
PATH_AUTOSTART_DESKTOP="$PATH_AUTOSTART/$NAME_SCRIPT.desktop"

PROCESS_CMD="$PATH_REPOSITORY/$NAME_SCRIPT daemon"
PROCESS_MATCH=$(ps ax | grep "$PROCESS_CMD" | head -n 1 | awk '{ print $5 }')

if [ "$(echo "$PROCESS_MATCH" | xargs)" != "bash" ] || [ -z "$PROCESS_MATCH" ]; then
	if [ ! -f "$PATH_AUTOSTART_DESKTOP" ]; then
		cp "$NAME_SCRIPT.desktop" "$PATH_AUTOSTART"
		echo "info: copied desktop autostart file"
	fi
	echo "Exec=/home/aindjare/Desktop/Projects/onlogout/watcher.sh daemon" >> "$PATH_AUTOSTART_DESKTOP"
	chmod +x "$PATH_REPOSITORY/$NAME_SCRIPT" && $PATH_REPOSITORY/$NAME_SCRIPT daemon & disown
	echo "success: now the monitor is on autostart and is currently active."
else
	echo "failure: please do not attempt re-installation while the monitor is running." >&2
fi
