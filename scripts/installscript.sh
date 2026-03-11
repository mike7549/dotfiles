#!/bin/bash

# set dotfiles directory
dotdir="$HOME/dotfiles"
configdir="$HOME/.config"
# update System before starting
sudo pacman -Syu wget base-devel

# change colors
dircolors -p > $HOME/.dircolors

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
    curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    nvim -u $dotdir/config/vim/init.vim -c :PlugInstall -c :q -c :q
    sudo nvim -u $dotdir/config/vim/init.vim -c :PlugInstall -c :q -c :q
    mkdir -p "$configdir/nvim/"
    ln -sf $dotdir/config/vim/init.vim $configdir/nvim/init.vim
    ln -sf $dotdir/config/vim/init.vim $HOME/.vimrc
}

function install_zsh {
    echo "<< Installing zsh and oh my zsh >>"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/mattmc3/antidote.git $HOME/.antidote

    sudo chsh -s /usr/bin/zsh
    chsh -s /usr/bin/zsh

    mkdir -p "$configdir/zsh/"
    ln -sf $dotdir/config/zsh/.zshrc $HOME/.zshrc
    ln -sf $dotdir/config/zsh/.zsh_plugins.txt $HOME/.zsh_plugins.txt

    mkdir -p "$HOME/.cache"
    ln -sf $dotdir/config/zsh/p10k-instant-prompt.zsh $HOME/.cache/p10k-instant-prompt.zsh
}

function create_symlinks {
    echo "<< Creating symlinks >>"
    # ranger
    mkdir -p $configdir/ranger/
    ln -sf $dotdir/config/ranger/rc.conf $configdir/ranger/rc.conf
    ln -sf $dotdir/config/ranger/rifle.conf $configdir/ranger/rifle.conf

    # rofi
    mkdir -p $configdir/rofi/themes
    ln -sf $dotdir/config/rofi/config.rasi $configdir/rofi/config.rasi
    ln -sf $dotdir/config/rofi/themes/nord.rasi $configdir/rofi/themes/nord.rasi

    # kitty
    mkdir -p $configdir/kitty
    ln -sf $dotdir/config/kitty/kitty.conf $configdir/kitty/kitty.conf
    ln -sf $dotdir/config/kitty/nord.conf $configdir/kitty/nord.conf

    #sway
    mkdir -p $configdir/sway
    ln -sf $dotdir/config/sway/config $configdir/sway/config

    #vivaldi
    mkdir -p $configdir/vivaldi/css
    ln -sf $dotdir/config/vivaldi/custom.css $configdir/vivaldi/css/custom.css

    #dolphin context menus
    context_menu_path=$HOME/.local/share/kio/servicemenus
    mkdir -p $context_menu_path
    for contextmenu in $dotdir/config/kde/contextmenu/*; do
        ln -sf $contextmenu $context_menu_path/$contextmenu
    done

    mkdir -p $configdir/gtk-3.0/
    ln -sf $dotdir/config/gtk/gtk.conf $configdir/gtk-3.0/settings.ini

    sudo mkdir -p "/etc/X11/xorg.conf.d/"
    sudo ln -sf $dotdir/config/xorg/keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf

    ln -sf $dotdir/config/picom/picom.conf $HOME/.picom.conf
    ln -sf $dotdir/config/chrome/chrome-flags.conf $configdir/chrome-flags.conf
    ln -sf $dotdir/config/electron/electron-flags.conf $configdir/electron-flags.conf
    ln -sf $dotdir/config/xorg/xinitrc $HOME/.xinitrc
}

install_yay
install_packages
install_neovim
install_zsh
create_symlinks

# detect sensors
yes | sudo sensors-detect

# build font cache
sudo fc-cache -f -v

# change colors
dircolors -p > $HOME/.dircolors

pyenv init