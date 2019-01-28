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
echo -e "${RED}7. quit${NC}"

while read input; do
	if [ $input -ge 1 -a $input -le 8 ]; then
		case $input in
		"1")
		echo -e "${GREEN}Installing General Packages${NC}"
		yay -S qbittorrent gdb valgrind  android-tools android-udev jre8-openjdk jre8-openjdk-headless
		;;
		"2")
		echo -e "${GREEN}Installing latex IDE${NC}"
		yay -S texstudio texlive-most 		
		;;
		"3")
		echo -e "${GREEN}Installing Java IDE${NC}"
		yay -S jdk-openjdk jre-openjdk jre-openjdk-headless jre8-openjdk jre8-openjdk-headless jdk8-openjdk java-openjfx intellij-idea-ultimate-edition 		
		;;
		"4")
		echo -e "${GREEN}Installing Android IDE${NC}"
		yay -S android-platform android-sdk-build-tools android-sdk-platform-tools android-sdk android-studio 
		;;
		"5")
		echo -e "${GREEN}Installing Gaming Packages${NC}"
		yay -S dolphin-emu steam steam-native-runtime wine-staging
		;;
		"6")
		echo -e "${GREEN}Installing Nvidia Packages${NC}"
		yay -S nvidia
		;;
		esac
		break
	elif [ $input = 7 ]; then
		echo -e "${GREEN}Exiting..${NC}"
		break
	else
		echo "invalid option, try again"
		continue
	fi
done
