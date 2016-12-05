#! /bin/bash

PRIMARY=$(xrandr | grep eDP | grep " connected" | awk '{print $1;}')
EXT1=$(xrandr | grep HDMI-0 | grep " connected" | awk '{print $1;}')
EXT2=$(xrandr | grep HDMI-1 | grep " connected" | awk '{print $1;}')

if ((xrandr | grep "$PRIMARY connected" && xrandr | grep "$EXT1 connected")); then
	xrandr --output $PRIMARY --primary --auto --output $EXT1 --auto --right-of $PRIMARY
	echo "$EXT1  enabled"
elif (xrandr | grep "$EXT2 connected" && xrandr | grep "$EXT1 connected"); then
	xrandr --output $EXT1 --primary --auto --output $EXT2 --auto --right-of $EXT1 
	echo "$EXT2 and $EXT1 enabled"
elif (xrandr | grep "$EXT1 disconnected" && xrandr | grep "$PRIMARY connected"); then
	xrandr --output $EXT1 --off
	xrandr --output $PRIMARY --primary --auto --output
	echo "$PRIMARY enabled"
else
	xrandr --output $EXT1 --off
	xrandr --output $PRIMARY --primary --auto
	echo "$PRIMARY enabled"
fi

