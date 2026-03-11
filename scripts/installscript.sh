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

    # kitty
    mkdir -p $configdir/kitty
    ln -sf $dotdir/config/kitty/kitty.conf $configdir/kitty/kitty.conf
    ln -sf $dotdir/config/kitty/nord.conf $configdir/kitty/nord.conf


    ln -sf $dotdir/config/picom/picom.conf $HOME/.picom.conf
    ln -sf $dotdir/config/chrome/chrome-flags.conf $configdir/chrome-flags.conf
    ln -sf $dotdir/config/electron/electron-flags.conf $configdir/electron-flags.conf
    ln -sf $dotdir/config/xorg/xinitrc $HOME/.xinitrc

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
install_zsh
create_symlinks
