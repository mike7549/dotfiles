# Dotfiles

Dotfiles for my Arch installation
https://github.com/login?client_id=01ab8ac9400c4e429b23&return_to=%2Flogin%2Foauth%2Fauthorize%3Fclient_id%3D01ab8ac9400c4e429b23%26code_challenge%3DmYGL-6XlfTKxxI8ynzF4j58kspVGj-y6Ag_zVvG8j_g%26code_challenge_method%3DS256%26get_started_with%3Dcopilot-vscode%26prompt%3Dselect_account%26redirect_uri%3Dhttps%253A%252F%252Fvscode.dev%252Fredirect%26scope%3Dread%253Auser%2Brepo%2Buser%253Aemail%2Bworkflow%26state%3Dhttp%253A%252F%252F127.0.0.1%253A45401%252Fcallback%253Fnonce%253DSZzvp1OUlnwKmDF547Gv9Q%25253D%25253D

## Installation

- clone the repository: `git clone https://github.com/mike7549/dotfiles`
- change to repository directory: `cd dotfiles`
- run: `sh scripts/installscript.sh`

### Post Install

#### Adding Drives to fstab

1.  Run `sudo blkid -f`
2.  Copy UUID of wanted drive
3.  Edit fstab: `sudo vim /etc/fstab`
4.  Add entry: `UUID=<UUID-of-drive> <mount-point> <type (e.g. ext4)> <options (e.g. defaults)> <dump> <pass>

#### Adding rules to ufw for sunshine

1. `sudo ufw allow from 192.168.50.0/24 to any port 47984,47989,47990,48010 proto tcp`
2. `sudo ufw allow from 192.168.50.0/24 to any port 47998:48002 proto udp`
3. `sudo ufw reload`

#### Autologin

1.  Go to system settings -> Login Screen
2.  Enable automatically login as user
3.  Open kwalletsettings
4.  Click change password for kwallet and set to empty password

#### Enable WOL

1. BIOS (MSI Click BIOS)

Press Del at boot, then F7 for Advanced mode.
Go to Settings → Advanced → Power Management Setup.
ErP Ready → Disabled. This setting cuts standby power to the NIC, so it must be off.
Go to Settings → Advanced → Wake Up Event Setup.
Resume By PCI-E Device → Enabled. The onboard LAN counts as a PCIe device.
Press F10 to save and reboot.

2. Linux: check support

```bash
ip link                      # find interface name, e.g. enp5s0
sudo ethtool enp5s0 | grep -i wake
```

Supports Wake-on: pumbg means the card can do it. Wake-on: d means it’s currently disabled.

3. Enable it permanently

If you use NetworkManager (most desktops):

```bash
nmcli c show                 # find your wired connection name
sudo nmcli c modify "Wired connection 1" 802-3-ethernet.wake-on-lan magic
sudo nmcli c up "Wired connection 1"
```

#### Proton Env variables

To set these globally, edit /etc/environment, and add these values:

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

#### Take ownership of other drives

sudo chown -R $USER:$USER <path/to/drive>
