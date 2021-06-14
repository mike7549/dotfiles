#!/bin/bash

homedir="$HOME"
rootdir='/root'
dotfiles="$homedir/dotfiles"

mkdir -p "$homedir/.config/termite/"
mkdir -p "$homedir/.config/ranger/"
mkdir -p "$homedir/.config/zsh/"
mkdir -p "$homedir/.config/nvim/"

ln -sf $dotfiles/ranger/rc.conf $homedir/.config/ranger/rc.conf
ln -sf $dotfiles/ranger/rifle.conf $homedir/.config/ranger/rifle.conf
ln -sf $dotfiles/vim/init.vim $homedir/.vimrc
ln -sf $dotfiles/vim/init.vim $homedir/.config/nvim/init.vim
ln -sf $dotfiles/config/google-chrome.conf $homedir/.config/google-chrome.conf
ln -sf $dotfiles/xorg/xinitrc $homedir/.xinitrc
ln -sf $dotfiles/config/picom.conf $homedir/.picom.conf
mkdir -p .config/gtk-3.0/ && ln -sf $dotfiles/config/gtk.ini $homedir/.config/gtk-3.0/settings.ini
ln -sf $dotfiles/termite/config $homedir/.config/termite/config
ln -sf $dotfiles/i3/i3blocks.conf $homedir/.i3blocks.conf
mkdir -p .config/networkmanager-dmenu/ && ln -sf $dotfiles/config/network_dmenu.conf $homedir/.config/networkmanager-dmenu/config.ini
ln -sf $dotfiles/zsh/zshrc $homedir/.zshrc
ln -sf $dotfiles/zsh/zlogin $homedir/.zlogin

sudo ln -sf $dotfiles/zsh/.zshrc $rootdir/.zshrc
sudo ln -sf $dotfiles/vim/init.vim $rootdir/.vimrc
sudo ln -sf $dotfiles/config/wifi_backend.conf /etc/NetworkManager/conf.d/wifi_backend.conf
mkdir -p /etc/X11/xorg.conf.d/ && sudo cp $dotfiles/config/00-keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf

sudo sh -c "if [ -d $rootdir/dotfiles ]; then sudo rm -rf $rootdir/dotfiles; fi"
sudo ln -s $dotfiles $rootdir/dotfiles

echo "export DOTFILES=$dotfiles" > $dotfiles/zsh/dotfiles.zsh
echo "export HOMEDIR=$homedir" > $dotfiles/zsh/dotfiles.zsh
