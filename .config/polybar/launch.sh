#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config
MONITOR=Virtual-1 polybar mainbar-bspwm 2>&1 | tee -a /tmp/polybar.log &
disown
# MONITOR=eDP polybar secondary-bspwm 2>&1 | tee -a /tmp/polybar.log &
disown

# echo "Polybar launched..."
# if type "xrandr"; then
# 	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
# 		MONITOR=$m polybar mainbar-bspwm 2>&1 | tee -a /tmp/polybar.log &
# 		disown
# 	done
# else
# 	polybar mainbar-bspwm 2>&1 | tee -a /tmp/polybar.log &
# 	disown
# fi
