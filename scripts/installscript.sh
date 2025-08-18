#!/bin/bash

# set dotfiles directory
dotdir="$HOME/dotfiles"
configdir="$HOME/.config"

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

    # kitty
    mkdir -p $configdir/kitty
    ln -sf $dotdir/config/kitty/kitty.conf $configdir/kitty/kitty.conf
    ln -sf $dotdir/config/kitty/nord.conf $configdir/kitty/nord.conf
    
    #dolphin context menus
    context_menu_path=$HOME/.local/share/kio/servicemenus
    mkdir -p $context_menu_path
    for contextmenu in $dotdir/config/kde/contextmenu/*; do
        ln -sf $contextmenu $context_menu_path/$(basename $contextmenu)
    done

    # fish
    mkdir -p $configdir/fish/functions
    fish_config_path=$configdir/fish
    ln -sf $dotdir/config/fish/config.fish $fish_config_path/config.fish
    ln -sf $dotdir/config/fish/functions/fish_prompt.fish $fish_config_path/functions/fish_prompt.fish
}

install_neovim
create_symlinks
