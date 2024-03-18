#! /bin/sh

mode=$1
direction=$2
if [ "$mode" = "f" ]; then
	bspc node -f $direction.local || bspc monitor -f $direction
else
	bspc node -$mode $direction.local || bspc node -m $direction --follow
fi
