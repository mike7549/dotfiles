#!/bin/bash
dotdir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$dotdir" || exit 1
configdir="$HOME/.config"

packages=(
    neovim
    wl-clipboard
    python
    python-pip
    jdk-openjdk
    java-runtime-common
    java-environment-common
    direnv
    pyenv
    android-tools
    visual-studio-code-bin
    vivaldi
    krdc
    freerdp
    libvncserver
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
    noto-fonts-cjk
    ttf-firacode-nerd
    fzf
    spotify-launcher
    gimp
    inkscape
    okular
    libresprite
    tk
    smbclient
    kio-fuse
    cifs-utils
    cachyos-samba-settings
    openbsd-netcat
    kdenetwork-filesharing
    sbctl
    mission-center
)

gaming=(
    steam
    lutris
    umu-launcher
    fuse2
    protonplus
    appmenu-gtk-module
    libdbusmenu-glib
    vesktop
)

devtools=(
    nodejs
    npm
    pnpm
    godot
)

function install_yay {
    if ! command -v yay &>/dev/null; then
        echo -e "\e[1;32m==>\e[0m Installing yay"
        sudo pacman -S --noconfirm yay
    fi
}

function install_packages {
    echo -e "\e[1;32m==>\e[0m Installing packages"
    read -p "Install packages? (yes/no): " confirm
    if [[ "$confirm" == "yes" ]]; then
        yay -S "${packages[@]}" --noconfirm --answerclean All --answerdiff All --answeredit All
    fi
}

function install_neovim {
    echo -e "\e[1;32m==>\e[0m Installing neovim"
    if [ "$(readlink $configdir/nvim/init.vim)" != "$dotdir/config/vim/init.vim" ]; then
        # init.vim downloads vim-plug itself if it's missing
        nvim --headless -u $dotdir/config/vim/init.vim +'PlugInstall --sync' +qa
        sudo nvim --headless -u $dotdir/config/vim/init.vim +'PlugInstall --sync' +qa
        mkdir -p "$configdir/nvim/"
        ln -sf $dotdir/config/vim/init.vim $configdir/nvim/init.vim
    else
        echo -e "\e[1;32m==>\e[0m init.vim already points to the right file, skipping"
    fi
}

function create_symlinks {
    echo -e "\e[1;32m==>\e[0m Creating symlinks"

    mkdir -p $configdir/alacritty/themes
    ln -sf $dotdir/config/alacritty/alacritty.toml $configdir/alacritty/alacritty.toml
    ln -sf $dotdir/config/alacritty/themes/dracula.toml $configdir/alacritty/themes/dracula.toml

    ln -sf $dotdir/config/chrome/chrome-flags.conf $configdir/chrome-flags.conf
    ln -sf $dotdir/config/chrome/chrome-flags.conf $configdir/vivaldi-stable.conf
    ln -sf $dotdir/config/electron/electron-flags.conf $configdir/electron-flags.conf

    # fish
    mkdir -p $configdir/fish/functions
    fish_config_path=$configdir/fish
    ln -sf $dotdir/config/fish/config.fish $fish_config_path/config.fish
    ln -sf $dotdir/config/fish/functions/fish_prompt.fish $fish_config_path/functions/fish_prompt.fish

    #dolphin context menus
    context_menu_path=$HOME/.local/share/kio/servicemenus
    mkdir -p $context_menu_path
    for contextmenu in $dotdir/config/kde/contextmenu/*; do
        ln -sf $contextmenu $context_menu_path/$(basename $contextmenu)
    done
}



function install_gaming {
	echo -e "\e[1;32m==>\e[0m Installing gaming packages"
    read -p "Install gaming packages? (yes/no): " confirm
    if [[ "$confirm" == "yes" ]]; then
        yay -S "${gaming[@]}" --noconfirm --answerclean All --answerdiff All --answeredit All
    fi
    read -p "Install sunshine? (yes/no): " confirm
    if [[ "$confirm" == "yes" ]]; then
        sh "$dotdir/scripts/sunshine/install-sunshine.sh"
    fi
}

function install_fish {
    echo -e "\e[1;32m==>\e[0m Installing fish"
    fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher && fisher install dracula/fish'
    if [ "$SHELL" != "/usr/bin/fish" ]; then
        sudo chsh -s /usr/bin/fish
        chsh -s /usr/bin/fish
    else
        echo "Shell is already fish, skipping"
    fi
}

function install_devtools {
	echo -e "\e[1;32m==>\e[0m Installing devtools"
	read -p "Install devtools? (yes/no): " confirm
	if [[ "$confirm" = "yes" ]]; then
		yay -S "${devtools[@]}" --answerclean All --answerdiff All --answeredit All
        sudo npm install -g @angular/cli ts-node
	fi
}

function install_run_kwin {
    echo -e "\e[1;32m==>\e[0m Installing run_kwin command"
    sudo ln -sf "$dotdir/scripts/run_kwin.sh" /usr/local/bin/run_kwin
}

function build_font_cache {
    echo -e "\e[1;32m==>\e[0m Building font cache"
    sudo fc-cache -f -v >/dev/null
}

install_yay
install_packages
install_neovim
install_gaming
install_fish
install_devtools
install_run_kwin
create_symlinks
build_font_cache

echo -e "\e[1;32m==>\e[0m Finished running install script"
