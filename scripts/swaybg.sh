#!/bin/bash

[ "${FLOCKER}" != "$0" ] && exec env FLOCKER="$0" flock -en "$0" "$0" "$@" || :

bg_dir="$HOME/dotfiles/pictures"


set_background() {
  background=$(find $bg_dir -type f -name "bg*.jpg" | shuf -n 1)
  swaymsg output "*" bg $background fill
  sleep 15m
}

while true; 
do
  set_background
done
