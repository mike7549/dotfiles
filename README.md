# Dotfiles

Dotfiles for my CachyOs installation.

## Contents

- [Installation](#installation)
- [Post install](#post-install)
  - [Drives](#drives)
  - [Networking](#networking)
  - [Desktop](#desktop)
  - [Gaming](#gaming)
  - [Misc](#misc)

## Installation

```bash
git clone https://github.com/mike7549/dotfiles
cd dotfiles
sh scripts/installscript.sh
```

## Post install

### Drives

#### Add drives to fstab

1. Find the drive's UUID:

   ```bash
   sudo blkid -f
   ```

2. Edit fstab:

   ```bash
   sudo vim /etc/fstab
   ```

3. Add an entry:

   ```
   UUID=<uuid> <mount-point> <type, e.g. ext4> <options, e.g. defaults> <dump> <pass>
   ```

#### Take ownership of other drives

```bash
sudo chown -R $USER:$USER <path/to/drive>
```

### Networking

#### Enable Wake-on-LAN

**1. BIOS (MSI Click BIOS)**

1. Press `Del` at boot, then `F7` for Advanced mode.
2. **Settings → Advanced → Power Management Setup**: set **ErP Ready** to **Disabled**. ErP cuts standby power to the NIC, so it must be off.
3. **Settings → Advanced → Wake Up Event Setup**: set **Resume By PCI-E Device** to **Enabled**. The onboard LAN counts as a PCIe device.
4. Press `F10` to save and reboot.

**2. Check Linux support**

```bash
ip link                          # find the interface name, e.g. enp5s0
sudo ethtool enp5s0 | grep -i wake
```

`Supports Wake-on: pumbg` means the card supports it. `Wake-on: d` means it's currently disabled.

**3. Enable it permanently (NetworkManager)**

```bash
nmcli c show                     # find the wired connection name
sudo nmcli c modify "Wired connection 1" 802-3-ethernet.wake-on-lan magic
sudo nmcli c up "Wired connection 1"
```

#### Samba / SMB1

See [configure-samba.md](configure-samba.md).

### Desktop

#### Autologin (KDE)

1. Open **System Settings → Login Screen**.
2. Enable **Automatically log in** as your user.
3. Open `kwalletsettings`.
4. Click **Change Password** for the wallet and set an empty password.

#### Run AppImages with a wake lock

Create `~/.local/share/applications/<app-name>.desktop` with the following content, edited as needed:

```ini
[Desktop Entry]
Type=Application
Name=<App Name>
Comment=<Comment>
Categories=<Category>
Icon=<path/to/icon>
Exec=systemd-inhibit --what=sleep:idle '--who=<App Name>' '--why=<Reason>' --mode=block </path/to/app-image> %U
Path=
Terminal=false
TerminalOptions=
StartupNotify=true
NoDisplay=false
PrefersNonDefaultGPU=false
X-KDE-SubstituteUID=false
X-KDE-Username=
```

### Gaming

#### Proton environment variables

Set these globally in `/etc/environment`:

```bash
sudo tee -a /etc/environment > /dev/null << 'EOF'
PROTON_ENABLE_WAYLAND=1
PROTON_ENABLE_HDR=1
DXVK_HDR=1
PROTON_FSR4_UPGRADE=1
PROTON_FSR4_RDNA3_UPGRADE=1
ENABLE_LAYER_MESA_ANTI_LAG=1
EOF
```

#### Allow Sunshine through ufw

```bash
sudo ufw allow from 192.168.50.0/24 to any port 47984,47989,47990,48010 proto tcp
sudo ufw allow from 192.168.50.0/24 to any port 47998:48002 proto udp
sudo ufw reload
```

### Misc

#### Add commands to PATH

```bash
sudo ln -s </path/to/command> /usr/local/bin/<command>
```
