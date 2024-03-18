#!/bin/sh
center() {
	id=$1
	floatwininfo=$(bspc query --node $id --tree)
	floatwinxcoords=$(echo "$floatwininfo" | cut -d ":" -f38 | cut -d "," -f1)
	floatwinycoords=$(echo "$floatwininfo" | cut -d ":" -f39 | cut -d "," -f1)
	floatwinwidth=$(echo "$floatwininfo" | cut -d ":" -f40 | cut -d "," -f1)
	floatwinheight=$(echo "$floatwininfo" | cut -d ":" -f41 | tr -d "}")
	monitorinfo=$(bspc query --monitor focused --tree)
	monitorwidth=$(echo "$monitorinfo" | cut -d ":" -f18 | cut -d "," -f1)
	monitorheight=$(echo "$monitorinfo" | cut -d ":" -f19 | cut -d "," -f1 | tr -d "}")
	bspc node $id -v $((($monitorwidth / 2) - $floatwinxcoords - ($floatwinwidth / 2))) $((($monitorheight / 2) - $floatwinycoords - ($floatwinheight / 2)))
}

sticky_ids=$(bspc query -N -n any.sticky)
sticky_focused=$(bspc query -N -n any.sticky.focused)
notify-send "$sticky_focused"

for id in $sticky_ids; do
	bspc node $id -g sticky=off
done

bspc desktop ^1:focused -s ^2:focused

for id in $sticky_ids; do
	bspc node $id -g sticky=on
	bspc node $id -m primary
	center $id
done

if [ -n "$sticky_focused" ]; then
	bspc node $sticky_focused --focus
fi
