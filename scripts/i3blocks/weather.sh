#!/bin/bash

curl -s "http://rss.accuweather.com/rss/liveweather_rss.asp?metric=1&locCode=EUR|AT|AU007|INNSBRUCK" | perl -ne 'use utf8; if (/Currently/) {chomp;/\<title\>Currently: (.*)?\<\/title\>/; my @values=split(":",$1);
binmode(STDOUT, ":utf8");
print"$values[0] $values[1]"}'
