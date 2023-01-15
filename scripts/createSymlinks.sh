#!/bin/bash

homedir="$HOME"
rootdir='/root'
dotfiles="$homedir/dotfiles/config"

# create directories
mkdir -p "$homedir/.config/ranger/"
mkdir -p "$homedir/.config/zsh/"
mkdir -p "$homedir/.config/nvim/"
mkdir -p "$homedir/.config/gtk-3.0/"
mkdir -p "$homedir/.config/rofi/themes"
mkdir -p "$homedir/.config/kitty"

# create symlinks
ln -sf $dotfiles/ranger/rc.conf $homedir/.config/ranger/rc.conf
ln -sf $dotfiles/ranger/rifle.conf $homedir/.config/ranger/rifle.conf
ln -sf $dotfiles/vim/init.vim $homedir/.vimrc
ln -sf $dotfiles/vim/init.vim $homedir/.config/nvim/init.vim
ln -sf $dotfiles/chrome/google-chrome.conf $homedir/.config/google-chrome.conf
ln -sf $dotfiles/picom/picom.conf $homedir/.picom.conf
ln -sf $dotfiles/gtk/gtk.conf $homedir/.config/gtk-3.0/settings.ini
ln -sf $dotfiles/rofi/config.rasi $homedir/.config/rofi/config.rasi
ln -sf $dotfiles/rofi/themes/nord.rasi $homedir/.config/rofi/themes/nord.rasi
ln -sf $dotfiles/kitty/kitty.conf $homedir/.config/kitty/kitty.conf
ln -sf $dotfiles/kitty/nord.conf $homedir/.config/kitty/nord.conf
ln -sf $dotfiles/sway/i3blocks.conf $homedir/.i3blocks.conf
ln -sf $dotfiles/zsh/zshrc $homedir/.zshrc
ln -sf $dotfiles/zsh/zlogin $homedir/.zlogin

sudo sh -c "if [ -d $rootdir/dotfiles ]; then sudo rm -rf $rootdir/dotfiles; fi"
sudo ln -s $dotfiles $rootdir/dotfiles
