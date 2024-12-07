#!/usr/bin/env bash

function write_err {
	echo "$1" >&2
}

function bt_pairing_clear_all {
	DEVICES=$(bluetoothctl devices | awk '{print $2}')
	for device in $DEVICES; do
		echo "$(date) | bluetoothctl remove $device" >> $HOME/.bluetooth_logout
		bluetoothctl remove $device
	done
}

if [ "$1" != "daemon" ]; then
	write_err "error: first parameter must be 'daemon'"
	exit 1
fi

trap "bt_pairing_clear_all; exit" SIGHUP # logout signal

while true; do
	sleep 60
done
