#!/bin/bash

if [[ $1 = "-g" ]]; then
	URL='https://www.google.com/search?q='
	QUERY=$(echo '' | dmenu -p "Google Search:" -sb '#745c97' -sf '#f5b0cb' -fn "Hack-12" -b)
elif [[ $1 = "-y" ]]; then
	URL='https://www.youtube.com/results?search_query='
	QUERY=$(echo '' | dmenu -p "YouTube Search:" -sb '#745c97' -sf '#f5b0cb' -fn "Hack-12" -b)
fi

if [ -n "$QUERY" ]; then
	xdg-open "${URL}${QUERY}" 2> /dev/null
	exec i3-msg [class="^chromium$"] focus
fi
