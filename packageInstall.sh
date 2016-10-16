#!/bin/bash
echo "Select which packages to install"
echo "1. General"
echo "2. Integrated Development Environments"
echo "3. Packages for Gaming"
echo "4. Packages for Dedicated Graphics Card"
echo "5. XMG specific"
echo "6. Others"

read input

case $input in
[1])
	echo "Installing General Packages"
	pacaur -S chromium qbittorrent ntfs-3g android-tools android-udev jre8-openjdk jre8-openjdk-headless telegram-desktop-bin thunderbird evince baka-mplayer chromium-widevine
	;;
[2])
	echo "Installing IDEs"
	pacaur -S texstudio texlive-most gdb valgrind jdk8-openjdk java-openjfx intellij-idea-ultimate-edition android-platform android-sdk-build-tools android-sdk-platform-tools android-sdk android-studio clion
	;;
[3])
	echo "Installing gaming stuff"
	pacaur -S dolphin-emu steam steam-native-runtime 
	;;
[4])
	pacaur -S nvidia opencl-nvidia lib32-opencl-nvidia lib32-nvidia-utils nvidia-utils nvidia-xrun
	;;
[5])
	pacaur -S ckb-git-latest
	;;
[6])
	pacaur -S rtl8812au_rtl8821au-dkms-git
	;;
*)  
	echo "Not a valid choice"
	;;
esac
