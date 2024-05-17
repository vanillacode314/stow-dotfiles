#!/bin/sh
if [ -f /tmp/polybarhidden ]; then
	polybar-msg cmd show
	bspc config bottom_padding 30
	rm /tmp/polybarhidden
else
	polybar-msg cmd hide
	bspc config bottom_padding 0
	touch /tmp/polybarhidden
fi
