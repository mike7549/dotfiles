# Dotfiles
Dotfiles for my Arch installation
<p align="center">
	<img src="pictures/screen.png" alt="Screeny"/>
</p>

## Installation
- clone the repository: `git clone https://github.com/mike7549/dotfiles`
- change to repository directory: `cd dotfiles`
- run: `sh scripts/installscript.sh`

## Configuration
- Download Files:
	- change permission: `chown user:group /path/to/downloads && chmod 1777 /path/to/downloads`
- Blacklist wlan:
	- add to /etc/modprobe.d/blacklist.conf: `blacklist ideapad_laptop`
- Refind manual boot stanzas:
	- Miix Notebook: 
	
	```
	Menuentry “Arch” {
		icon /EFI/refind/themes/rEFInd-minimal/icons/os_arch.png
		volume “Arch Linux”
		loader /vmlinuz-linux
		initrd /intel-ucode.img
		initrd /initramfs-linux.img
		options “rw root=UUID=... quiet vga=current loglevel=3 rd.systemd.show_status=auto rd.udev.log-priority=3 splash pcie_aspm=off”
	}

	menuentry “Windows” {
		icon /EFI/refind/themes/rEFInd-minimal/icons/os_win.png
		loader	\EFI\Microsoft\Boot\bootmgfw.efi
	}
	```
- Rename device name for pulse audio:
	- add to /etc/pulse/default.pa: `load-module module-device-manager`
	- in pavucontrol right click on the combo box widget next to port in in/output devices

### Network Configuration
- Enable networking and resolving:
	Edit /etc/iwd/main.conf
	```
		[General]
		EnableNetworkConfiguration=true

		[Network]
		NameResolvingService=systemd
	```

### Firefox Custom Theme
1. Type about:profiles into your urlbar and go to the page
2. Open the root directory folder specified on the page
3. `mkdir chrome`
4. `cp config/firefox/userchrome.css <path-to-root-profile-dir>`
5. Edit in about:config:

	`toolkit.legacyUserProfileCustomizations.stylesheets` &rarr; set to true

	`ui.prefersReducedMotion` &rarr; set to 1

### Firefox Tweaks
- Disable Fullscreen Message: `full-screen-api.warning.timeout` &rarr; set to 0
- Prevent screen tearing issues: `layers.acceleration.force-enabled` &rarr; set to true
- Disable pocket: `extensions.pocket.enabled` &rarr; set to false
