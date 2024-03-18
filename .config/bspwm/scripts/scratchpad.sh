#!/usr/bin/env bash

# ScratchPad
bspc rule -a dropdown-${1} sticky=on state=floating hidden=on center=on monitor=primary rectangle=1280x720+0+0
pids=$(xdotool search --class ${1})
if [ -z "$pids" ]; then
	kitty --class dropdown-${1} -- "$@" &
	sleep 0.2
fi

pids=$(xdotool search --class ${1})
for pid in $pids; do
	bspc node $pid --flag hidden -f
done
