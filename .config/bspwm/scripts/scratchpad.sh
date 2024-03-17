#!/usr/bin/env bash

if [ -z $1 ]; then
	echo "Usage: $0 <name of hidden scratchpad window>"
	exit 1
fi

pids=$(xdotool search --class ${1})
if [ -z "$pids" ]; then
	if tmux ls | grep scratchpad -q; then
		kitty --class dropdown -- tmux a -t scratchpad &
	else
		kitty --class dropdown -- tmux new -s scratchpad &
	fi

	sleep 0.2
fi

pids=$(xdotool search --class ${1})
for pid in $pids; do
	bspc node $pid --flag hidden -f
done
