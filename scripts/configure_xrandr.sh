#! /bin/bash

PRIMARY=$(xrandr | grep -m1 " connected" | awk '{print $1;}')
EXT1=$(xrandr | grep HDMI | grep " connected" | awk '{print $1;}')

if ((xrandr | grep "$PRIMARY connected") && (xrandr | grep "$EXT1 connected")); then
	xrandr --output $PRIMARY --primary --auto --output $EXT1 --auto --right-of $PRIMARY
	echo "$EXT1  enabled"
else
	xrandr --output $EXT1 --off
	xrandr --output $PRIMARY --primary --auto
	echo "$PRIMARY enabled"
fi

