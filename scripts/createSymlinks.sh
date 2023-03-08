#!/bin/bash

homedir="$HOME"
rootdir='/root'
dotfiles="$homedir/dotfiles/config"
configdir="$homedir/.config"

# create directories
mkdir -p "$configdir/ranger/"
mkdir -p "$configdir/zsh/"
mkdir -p "$configdir/nvim/"f
mkdir -p "$configdir/gtk-3.0/"
mkdir -p "$configdir/rofi/themes"
mkdir -p "$configdir/kitty"

# create symlinks
ln -sf $dotfiles/ranger/rc.conf $configdir/ranger/rc.conf
ln -sf $dotfiles/ranger/rifle.conf $configdir/ranger/rifle.conf
ln -sf $dotfiles/vim/init.vim $homedir/.vimrc
ln -sf $dotfiles/vim/init.vim $configdir/nvim/init.vim
ln -sf $dotfiles/chrome/chrome-flags.conf $configdir/chrome-flags.conf
ln -sf $dotfiles/electron/electron-flags.conf $configdir/electron-flags.conf
ln -sf $dotfiles/gtk/gtk.conf $configdir/gtk-3.0/settings.ini
ln -sf $dotfiles/rofi/config.rasi $configdir/rofi/config.rasi
ln -sf $dotfiles/rofi/themes/nord.rasi $configdir/rofi/themes/nord.rasi
ln -sf $dotfiles/kitty/kitty.conf $configdir/kitty/kitty.conf
ln -sf $dotfiles/kitty/nord.conf $configdir/kitty/nord.conf
ln -sf $dotfiles/zsh/zshrc $homffedir/.zshrc
ln -sf $dotfiles/zsh/zlogin $homedir/.zlogin

sudo sh -c "if [ -d $rootdir/dotfiles ]; then sudo rm -rf $rootdir/dotfiles; fi"
sudo ln -s $dotfiles $rootdir/dotfiles
