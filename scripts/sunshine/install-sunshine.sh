#!/bin/bash

dotdir=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
configdir="$HOME/.config"

function install_sunshine {
    echo -e "\e[1;32m==>\e[0m Installing sunshine"
    yay -S --noconfirm sunshine
    sudo setcap cap_sys_admin+p $(readlink -f $(which sunshine))
}

function create_config_dirs {
    mkdir -p $configdir/sunshine
    mkdir -p $configdir/systemd/user/sunshine.service.d
}

function create_symlinks {
    ln -sf $dotdir/config/sunshine/apps.json $configdir/sunshine/apps.json
    ln -sf $dotdir/config/sunshine/sunshine.conf $configdir/sunshine/sunshine.conf
    ln -sf $dotdir/config/sunshine/undo-on-crash.conf $configdir/systemd/user/sunshine.service.d/undo-on-crash.conf
}

function install_hooks {
    echo -e "\e[1;32m==>\e[0m Setting up sleep and shutdown hook"
    sudo ln -sf $dotdir/scripts/sunshine/sunshine-sleep-hook.sh /lib/systemd/system-sleep/sunshine-sleep-hook
    sudo ln -sf $dotdir/scripts/sunshine/sunshine-shutdown-hook.sh /lib/systemd/system-shutdown/sunshine-shutdown-hook
}

function install_systemd_service {
    echo -e "\e[1;32m==>\e[0m Enabling sunshine systemd service"
    systemctl --user enable --now sunshine
}

function export_scripts {
    echo -e "\e[1;32m==>\e[0m Exporting scripts to PATH"
    read -p "Export scripts? (yes/no): " confirm
    if [[ "$confirm" == "yes" ]]; then
        sudo ln -s $dotdir/scripts/sunshine/sunshine-prep.sh /usr/local/bin/sunshine-prep
        sudo ln -s $dotdir/scripts/sunshine/sunshine-undo.sh /usr/local/bin/sunshine-undo
    fi
}

install_sunshine
create_config_dirs
create_symlinks
install_hooks
install_systemd_service
export_scripts