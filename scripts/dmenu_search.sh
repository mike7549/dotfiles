#!/bin/bash

if [[ $1 = "-g" ]]; then
	URL='https://www.google.com/search?q='
elif [[ $1 = "-y" ]]; then
	URL='https://www.youtube.com/results?search_query='
fi

QUERY=$(echo '' | dmenu -p "Search:" -sb '#a89984' -sf '#32302f' -fn "Hack-13" -b)
if [ -n "$QUERY" ]; then
	xdg-open "${URL}${QUERY}" 2> /dev/null
	exec i3-msg [class="^chromium$"] focus
fi
