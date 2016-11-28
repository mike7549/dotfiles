#!/bin/bash

PRIMARY=$(xrandr | grep eDP | grep " connected" | awk '{print $1;}')
EXT1=$(xrandr | grep HDMI | grep " connected" | awk '{print $1;}')
EXT2=$(xrandr | grep DVI | grep " connected" | awk '{print $1;}')

if ((xrandr | grep "$PRIMARY connected") && (xrandr | grep "$EXT1 connected")); then
	xrandr --output $PRIMARY --primary --auto --output $EXT1 --auto --same-as $PRIMARY
	echo "asdf$PRIMARY & $EXT1 mirrored"
elif (xrandr | grep "$EXT1 connected" && xrandr | grep "EXT2 connected"); then
	xrandr --output $EXT1 --primary --auto --output $EXT2 --auto --same-as $EXT1
	echo "bbbbbbrg$EXT1 & $EXT2 mirrored"
elif (xrandr | grep "$PRIMARY disconnected" && xrandr | grep "$EXT1 connected"); then
	xrandr --output $EXT1 --primary --auto
elif (xrandr | grep "$PRIMARY disconnected" && xrandr | grep "$EXT2 connected" && xrandr | grep "$EXT1 disconnected"); then
	xrandr --output $EXT2 --primary --auto
else
	xrandr --output $EXT1 --primary --auto
	xrandr --output $EXT2 --primary --auto
	xrandr --output $PRIMARY --primary --auto
	echo "ghgh$PRIMARY enabled"
fi
