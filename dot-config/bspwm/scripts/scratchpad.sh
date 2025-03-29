#!/usr/bin/env bash

pids=$(xdotool search --class dropdown-${1})
focused_monitor=$(bspc query -M -m focused)
if [ -z "$pids" ]; then
	bspc rule -a dropdown-${1} sticky=on state=floating hidden=on center=on rectangle=1280x720+0+0
	kitty --class dropdown-${1} -- "$@" &
	sleep 0.5
fi

pids=$(xdotool search --class dropdown-${1})
for pid in $pids; do
	bspc node $pid --flag hidden -f --to-monitor $focused_monitor --follow
done
