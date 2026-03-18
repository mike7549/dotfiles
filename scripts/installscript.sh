#!/bin/bash

# set dotfiles directory
dotdir=$(pwd)
configdir="$HOME/.config"

function install_packages {
    echo ">> Installing packages"
    read -p "Install packages? (yes/no): " confirm
    if [[ "$confirm" == "yes" ]]; then
        yay -S $(cat $dotdir/scripts/packages) --answerclean All --answerdiff All --answeredit All
    fi
}

function install_neovim {
    echo ">> Installing neovim"
    if [ "$(readlink $configdir/nvim/init.vim)" != "$dotdir/config/vim/init.vim" ]; then
        sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        nvim -u $dotdir/config/vim/init.vim -c :PlugInstall -c :q -c :q
        sudo nvim -u $dotdir/config/vim/init.vim -c :PlugInstall -c :q -c :q
        mkdir -p "$configdir/nvim/"
        ln -sf $dotdir/config/vim/init.vim $configdir/nvim/init.vim
        ln -sf $dotdir/config/vim/init.vim $HOME/.vimrc
    else
        echo "init.vim already points to the right file, skipping"
    fi
}

function create_symlinks {
    echo ">> Creating symlinks"

    mkdir -p $configdir/alacritty/themes
    ln -sf $dotdir/config/alacritty/alacritty.toml $configdir/alacritty/alacritty.toml
    ln -sf $dotdir/config/alacritty/themes/dracula.toml $configdir/alacritty/themes/dracula.toml

    ln -sf $dotdir/config/chrome/chrome-flags.conf $configdir/chrome-flags.conf
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

function install_fish {
    echo ">> Installing fish"
    if [ "$SHELL" != "/usr/bin/fish" ]; then
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
        sudo chsh -s /usr/bin/fish
        chsh -s /usr/bin/fish
        fisher install dracula/fish
        fish_config theme choose Dracula
    else
        echo "Shell is already fish, skipping"
    fi
}

function install_devtools {
	echo ">> Installing devtools"
	read -p "Install devtools? (yes/no): " confirm
	if [[ "$confirm" = "yes" ]]; then
		yay -S $(cat $dotdir/scripts/packages-devtools) --answerclean All --answerdiff All --answeredit All
		echo ">> accepting licenses"
        sudo chown -R $(whoami) /opt/android-studio
        sudo chown -R $(whoami) /opt/android-sdk
        sudo sh /opt/android-sdk/cmdline-tools/latest/bin/sdkmanager --licenses
        sudo npm install -g @angular/cli @ionic/cli @capacitor/cli ts-node
	fi
}


install_packages
install_neovim
install_fish
install_devtools

create_symlinks

sudo fc-cache -f -v
echo ">> Finished running install script"
