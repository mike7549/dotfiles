#!/bin/bash
RED='\033[1;31m'
CYAN='\033[0;36m'
NC='\033[0m'
GREEN='\033[0;32m'
echo -e "${CYAN}Select which packages to install"
echo -e "${RED}1. General"
echo -e "${RED}2. Latex IDE"
echo -e "${RED}3. Java IDE"
echo -e "${RED}4. Android IDE"
echo -e "${RED}5. Packages for Gaming"
echo -e "${RED}6. Packages for Dedicated Graphics Card"
echo -e "${RED}7. XMG specific"
echo -e "${RED}8. Others"
echo -e "${RED}q. quit${NC}"

while read input; do
	if [ $input -ge 1 -a $input -le 6 ]; then
		case $input in
		"1")
		echo -e "${GREEN}Installing General Packages${NC}"
		pacaur -S chromium qbittorrent gdb valgrind  android-tools android-udev jre8-openjdk jre8-openjdk-headless telegram-desktop-bin thunderbird evince baka-mplayer chromium-widevine
		;;
		"2")
		echo -e "${GREEN}Installing latex IDE${NC}"
		pacaur -S texstudio texlive-most 		
		;;
		"3")
		echo -e "${GREEN}Installing Java IDE${NC}"
		pacaur -S jdk8-openjdk java-openjfx intellij-idea-ultimate-edition 		
		;;
		"4")
		echo -e "${GREEN}Installing Android IDE${NC}"
		pacaur -S android-platform android-sdk-build-tools android-sdk-platform-tools android-sdk android-studioi
		;;
		"5")
		echo -e "${GREEN}Installing Gaming Packages${NC}"
		pacaur -S dolphin-emu steam steam-native-runtime 
		;;
		"6")
		echo -e "${GREEN}Installing Nvidia Packages${NC}"
		pacaur -S nvidia opencl-nvidia lib32-opencl-nvidia lib32-nvidia-utils nvidia-utils nvidia-xrun
		;;
		"7")
		echo -e "${GREEN}Installing XMG Packages${NC}"
		pacaur -S ckb-git-latest
		;;
		"8")
		echo -e "${GREEN}Installing Other Packages${NC}"
		pacaur -S rtl8812au_rtl8821au-dkms-git
		;;
		esac
		break
	elif [ $input == q ]; then
		break
	else
		echo "invalid option, try again"
		continue
	fi
done
