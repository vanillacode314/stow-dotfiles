#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

IFS="
"
i=0
for line in $(xrandr --listactivemonitors); do
	if [ $i -eq 0 ]; then
		i=$((i + 1))
		continue
	fi
	IS_PRIMARY=$(
		echo "$line" | grep -F '*' -q
		echo $?
	)
	MONITOR=$(echo $line | cut -d' ' -f6)
	export MONITOR
	if [ $IS_PRIMARY -eq 0 ]; then
		polybar mainbar-bspwm 2>&1 | tee -a /tmp/polybar.log &
	else
		polybar secondary-bspwm 2>&1 | tee -a /tmp/polybar.log &
	fi
	disown
	i=$((i + 1))
done
