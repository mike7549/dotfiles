#!/bin/bash

homedir="$HOME"
rootdir='/root'
dotfiles="$homedir/dotfiles"

mkdir -p "$homedir/.config/termite/"
mkdir -p "$homedir/.config/ranger/"
sudo mkdir -p "$rootdir/.config/ranger/"

ln -sf $dotfiles/ranger/rc.conf $homedir/.config/ranger/rc.conf
ln -sf $dotfiles/zsh/.zshrc $homedir/.zshrc
touch $homedir/.vimrc
ln -sf $dotfiles/vim/init.vim $homedir/.vimrc
mkdir -p $homedir/.config/nvim/ && touch $homedir/.config/nvim/init.vim
ln -sf $dotfiles/vim/init.vim $homedir/.config/nvim/init.vim
ln -sf $dotfiles/xorg/.xinitrc $homedir/.xinitrc
ln -sf $dotfiles/termite/config $homedir/.config/termite/config
ln -sf $dotfiles/i3/i3blocks.conf $homedir/.i3blocks.conf
ln -sf $dotfiles/.compton.conf $homedir/.compton.conf
ln -sf $dotfiles/zsh/.zlogin $homedir/.zlogin
mkdir -p $homedir/.config/mpv/ && touch $homedir/.config/mpv/mpv.conf
ln -sf $dotfiles/.mpv.conf $homedir/.config/mpv/mpv.conf

sudo touch /etc/NetworkManager/dispatcher.d/99-wlan
sudo ln -sf $dotfiles/scripts/wlan-on /etc/NetworkManager/dispatcher.d/99-wlan
sudo ln -sf $dotfiles/ranger/rc.conf $rootdir/.config/ranger/rc.conf
sudo ln -sf $dotfiles/ranger/rifle.conf $rootdir/.config/ranger/rifle.conf
sudo ln -sf $dotfiles/zsh/.zshrc $rootdir/.zshrc
sudo touch $rootdir/.vimrc
sudo ln -sf $dotfiles/vim/init.vim $rootdir/.vimrc

sudo sh -c "if [ -d $rootdir/dotfiles ]; then sudo rm -rf $rootdir/dotfiles; fi"
sudo ln -s $dotfiles $rootdir/dotfiles

echo "export DOTFILES=$dotfiles" > $dotfiles/zsh/dotfiles.zsh
echo "export HOMEDIR=$homedir" >> $dotfiles/zsh/dotfiles.zsh
