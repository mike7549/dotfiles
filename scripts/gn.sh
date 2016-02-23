#!/bin/bash

function countdown(){
   date1=$((`date +%s` + $1)); 
   while [ "$date1" -ge `date +%s` ]; do 
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 0.1
   done
   `poweroff`
}

MOV="$(find ~/myDrive/Filme -type f -print0 | xargs -0 ls -t | shuf -n1)"
baka-mplayer "$MOV" &
countdown 2

