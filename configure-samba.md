# ASUS RT-AX58U USB share on CachyOS (KDE / Dolphin)

Mounts the router's USB drive shares (`Series`, `Movies`) as regular folders under `/media`, using a systemd automount. No password prompts, works in every app.

## Background / gotchas

- The router (firmware 3.0.0.4.388_25277) only speaks **SMB1**. Modern clients default to SMB2+, so the mount must use `vers=1.0`.
- Each top-level folder on the drive is its **own share** (`//192.168.50.1/Series`), not a subfolder of `USB`.
- The router allows only a few concurrent connections by default (5), which causes `NT_STATUS_INSUFFICIENT_RESOURCES`.
- The **Reboot** button in the router UI may not actually reboot it. If settings don't apply, unplug the power for ~30 s.

---

## 1. Router setup (http://192.168.50.1)

**USB Application → Network Place (Samba) Share / Cloud Disk**

1. **Enable Share**: ON
2. **Allow guest login**: OFF
3. **Maximum number of concurrent connections**: 20
4. Click **Apply**
5. Select your user (e.g. `mike3`), set the folders (`Movies`, `Series`) to **R/W**, click **Save**
6. If the service doesn't respond: toggle Enable Share OFF → Apply → ON → Apply, or power-cycle the router

Verify from the PC:

```bash
sudo pacman -S --needed openbsd-netcat
nc -zv 192.168.50.1 445
```

Port 445 should report *succeeded*.

---

## 2. Client packages

```bash
sudo pacman -S --needed cifs-utils smbclient
```

## 3. Credentials file

```bash
sudo nano /etc/samba/router-cred
```

```
username=mike3
password=YOURPASSWORD
```

```bash
sudo chmod 600 /etc/samba/router-cred
```

Keep it root-only. Don't make it world-readable.

## 4. Mount points

```bash
sudo mkdir -p /media/Series /media/Movies
```

## 5. fstab entries

Check your user ID first with `id -u` and replace `1000` if it differs.

```bash
sudo nano /etc/fstab
```

```
//192.168.50.1/Series  /media/Series  cifs  credentials=/etc/samba/router-cred,vers=1.0,uid=1000,gid=1000,iocharset=utf8,noauto,x-systemd.automount,_netdev  0 0
//192.168.50.1/Movies  /media/Movies  cifs  credentials=/etc/samba/router-cred,vers=1.0,uid=1000,gid=1000,iocharset=utf8,noauto,x-systemd.automount,_netdev  0 0
```

Validate:

```bash
sudo findmnt --verify
```

## 6. Activate the automount

Unit names come from the mount path (`/media/Series` → `media-Series.automount`, case-sensitive).

```bash
sudo systemctl daemon-reload
sudo systemctl start media-Series.automount media-Movies.automount
systemctl status media-Series.automount   # should say: active (waiting)
```

They start automatically on every boot after this.

## 7. Dolphin

- Open `/media/Series` by **typing the path** in the address bar. It mounts on first access.
- Right-click the folder → **Add to Places**.
- Don't click the share in the **Devices** list. That makes Dolphin mount it as your user, which fails with `error 13 (Permission denied) opening credential file`. Right-click → **Hide** to remove it from there.

---

## Optional: browsing via smb:// and smbclient

Only needed if you want to use `smb://` URLs or `smbclient` for testing.

Allow SMB1 on the client side in `/etc/samba/smb.conf`:

```ini
[global]
   client min protocol = NT1
```

```bash
smbclient -L //192.168.50.1 -U mike3                                   # list shares
smbclient //192.168.50.1/Series -U mike3 -c 'mkdir test; rmdir test'   # test write access
```

If you need `smb://` in Dolphin, put the user in the URL: `smb://mike3@192.168.50.1/Series`. Remove stale logins in **KWalletManager**.

`smb.service` / `nmb.service` are **not** needed; they're for sharing *from* this PC.

---

## Troubleshooting

| Error | Cause | Fix |
|---|---|---|
| `NT_STATUS_CONNECTION_REFUSED` | Samba not running on the router | Toggle Enable Share / power-cycle the router |
| `Protocol negotiation ... failed: NT_STATUS_INVALID_PARAMETER` | Router only speaks SMB1 | `vers=1.0` (mount) or `client min protocol = NT1` (smbclient) |
| `NT_STATUS_BAD_NETWORK_NAME` | Wrong share name | Use the folder as the share: `//192.168.50.1/Series` |
| `NT_STATUS_INSUFFICIENT_RESOURCES` | Too many concurrent connections | Raise the limit in the router to 20; close Dolphin / log out |
| `NT_STATUS_LOGON_FAILURE` / password prompt loop | Wrong password or stale KWallet entry | Reset the password in the router (pencil icon); clear KWallet |
| `NT_STATUS_ACCESS_DENIED` | User lacks R/W, or drive mounted read-only | Set R/W in the router; repair NTFS with `chkdsk X: /f` on Windows |
| `error 13 ... opening credential file` | Dolphin mounting as your user | Open the path `/media/Series` instead of the Devices entry |
| `Unit ... .automount not found` | Wrong unit name or fstab not reloaded | `systemctl list-units --all '*.automount'`, `daemon-reload` |

Mount errors: `sudo dmesg | tail` and `journalctl -u media-Series.mount -n 20`

## Maintenance notes

- A folder named `ntfsck.00000000` on the drive means the router found NTFS errors. Repair it on a Windows PC with `chkdsk X: /f` when possible.
- Check for router firmware updates under **Administration → Firmware Upgrade**. A newer version may add SMBv2 support, after which `vers=1.0` can be changed to `vers=2.0` or removed.
