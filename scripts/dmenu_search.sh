#!/bin/bash

if [[ $1 = "-g" ]]; then
	URL='https://www.google.com/search?q='
	QUERY=$(echo '' | dmenu -p "Google Search:" -sb '#8fa1b3' -sf '#2b303b' -fn "Hack-13" -b)
elif [[ $1 = "-y" ]]; then
	URL='https://www.youtube.com/results?search_query='
	QUERY=$(echo '' | dmenu -p "YouTube Search:" -sb '#8fa1b3' -sf '#2b303b' -fn "Hack-13" -b)
fi

if [ -n "$QUERY" ]; then
	xdg-open "${URL}${QUERY}" 2> /dev/null
	exec i3-msg [class="^chromium$"] focus
fi
