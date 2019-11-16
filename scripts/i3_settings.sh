#!/bin/bash

DMENU="dmenu -b -i -l 10 -w 640 -p > -nf #d597ce -nb #39375b -sb #745c97 -sf #f5b0cb -fn 'Hack-12'"
ACTION="$(printf "Audio Options\ni3 Options\nSystem Options\nGoodnight\nBack\n" | $DMENU $*)"


if [ "$ACTION" == "System Options" ]
then
	ACTION="$(printf "Do Nothing\nScreensaver\nExit i3\nLogout\nReboot\nPoweroff\n" | $DMENU $*)"
	if [ "$ACTION" == "Screensaver" ]
	then
		sh ~/dotfiles/scripts/i3lock.sh
	elif [ "$ACTION" == "Exit i3" ]
	then
		i3-msg exit
	elif [ "$ACTION" == "Logout" ]
	then
		logout
	elif [ "$ACTION" == "Reboot" ]
	then
		reboot
	elif [ "$ACTION" == "Poweroff" ]
	then 
		poweroff
	fi
elif [ "$ACTION" == "Audio Options" ]
then
	ACTION="$(printf "Change Default Output\nChange Application Output\nChange Default Input\nChange Application Input\nBack\n" | $DMENU $*)"
	if [ "$ACTION" == "Change Default Output" ]
	then
		sh ~/dotfiles/scripts/settings/pulse_change_default_output.sh "$DMENU"
	elif [ "$ACTION" == "Change Application Output" ]
	then
		sh ~/dotfiles/scripts/settings/pulse_change_application_output.sh "$DMENU"
	elif [ "$ACTION" == "Change Application Input" ]
	then
		sh ~/dotfiles/scripts/settings/pulse_change_application_input.sh "$DMENU"
	fi
elif [ "$ACTION" == "i3 Options" ]
then
	ACTION="$(printf "Reload Config\nRestart i3\nBack\n" | $DMENU $*)"
	if [ "$ACTION" == "Reload Config" ]
	then
		i3-msg reload
	elif [ "$ACTION" == "Restart i3" ]
	then
		i3-msg restart
	fi
elif [ "$ACTION" == "Goodnight" ]
then
	sh ~/dotfiles/scripts/gn.sh
fi
