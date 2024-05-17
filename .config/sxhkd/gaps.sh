#!/bin/sh
if [ $(bspc config border_width) -eq 0 ]; then
	bspc config border_width 1
else
	bspc config border_width 0
fi
