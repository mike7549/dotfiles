#!/bin/bash

if [[ $1 = "-g" ]]; then
	URL='https://www.google.com/search?q='
	QUERY=$(echo '' | rofi -config ~/dotfiles/config/rofi/search.rasi -dmenu -p "")
elif [[ $1 = "-y" ]]; then
	URL='https://www.youtube.com/results?search_query='
	QUERY=$(echo '' | rofi -config ~/dotfiles/config/rofi/search.rasi -dmenu -p "")
fi

if [ -n "$QUERY" ]; then
	xdg-open "${URL}${QUERY}" 2> /dev/null
fi
