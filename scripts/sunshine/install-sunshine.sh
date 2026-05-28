#!/bin/bash

dotdir=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
configdir="$HOME/.config"

function export_scripts {
    echo ">> Exporting scripts to PATH"
    read -p "Export scripts? (yes/no): " confirm
    if [[ "$confirm" == "yes" ]]; then
        sudo ln -s $dotdir/scripts/sunshine/sunshine-prep.sh /usr/local/bin/sunshine-prep
        sudo ln -s $dotdir/scripts/sunshine/sunshine-undo.sh /usr/local/bin/sunshine-undo
    fi
}

echo ">> Installing sunshine"
yay -S --noconfirm sunshine
sudo setcap cap_sys_admin+p $(readlink -f $(which sunshine))
mkdir -p $configdir/sunshine
ln -sf $dotdir/config/sunshine/apps.json $configdir/sunshine/apps.json
ln -sf $dotdir/config/sunshine/sunshine.conf $configdir/sunshine/sunshine.conf
mkdir -p $configdir/systemd/user/sunshine.service.d
ln -sf $dotdir/config/sunshine/undo-on-crash.conf $configdir/systemd/user/sunshine.service.d/undo-on-crash.conf
echo ">> Setting up sleep and shutdown hook"
sudo ln -sf $dotdir/scripts/sunshine/sunshine-sleep-hook.sh /lib/systemd/system-sleep/sunshine-sleep-hook
sudo ln -sf $dotdir/scripts/sunshine/sunshine-shutdown-hook.sh /lib/systemd/system-shutdown/sunshine-shutdown-hook
systemctl --user enable --now sunshine
export_scripts