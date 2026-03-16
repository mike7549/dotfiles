#!/bin/bash

# set dotfiles directory
dotdir=$(pwd)
configdir="$HOME/.config"

function install_yay {
    echo "<< Installing yay >>"
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si
    cd .. && rm -rf yay-bin
}

function install_packages {
    echo "<< Installing packages >>"
    yay -S $(cat $dotdir/scripts/packages)  --answerclean All --answerdiff All --answeredit All
}

function install_neovim {
    echo "<< Installing neovim >>"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    nvim -u $dotdir/config/vim/init.vim -c :PlugInstall -c :q -c :q
    sudo nvim -u $dotdir/config/vim/init.vim -c :PlugInstall -c :q -c :q
    mkdir -p "$configdir/nvim/"
    ln -sf $dotdir/config/vim/init.vim $configdir/nvim/init.vim
    ln -sf $dotdir/config/vim/init.vim $HOME/.vimrc
}

function create_symlinks {
    echo "<< Creating symlinks >>"

    mkdir -p $configdir/alacritty
    ln -sf $dotdir/config/alacritty/alacritty.toml $configdir/alacritty/alacritty.toml


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

if [ $(lsb_release -si) = 'Arch' ]; then
    install_yay
fi

read -p "Install packages? (yes/no): " confirm
if [[ "$confirm" == "yes" ]]; then
    install_packages
fi

install_neovim

sudo chsh -s /usr/bin/fish
chsh -s /usr/bin/fish
create_symlinks
