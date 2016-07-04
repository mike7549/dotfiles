#!/bin/bash

homedir="$HOME"
rootdir='/root'
dotfiles="$homedir/dotfiles"

mkdir -p "$homedir/.config/termite/"
mkdir -p "$homedir/.config/ranger/"
sudo mkdir -p "$rootdir/.config/ranger/"

ln -sf $dotfiles/ranger/rc.conf $homedir/.config/ranger/rc.conf
ln -sf $dotfiles/zsh/.zshrc $homedir/.zshrc
ln -sf $dotfiles/vim/init.vim $homedir/.vimrc
ln -sf $dotfiles/xorg/.xinitrc $homedir/.xinitrc
ln -sf $dotfiles/termite/config $homedir/.config/termite/config
#ln -sf $dotfiles/i3/config $homedir/.i3/config
ln -sf $dotfiles/i3/i3blocks.conf $homedir/.i3blocks.conf
ln -sf $dotfiles/xorg/Xresources $homedir/.Xresources
ln -sf $dotfiles/.bashrc $homedir/.bashrc
ln -sf $dotfiles/.dircolors $homedir/.dircolors
ln -sf $dotfiles/.compton.conf $homedir/.compton.conf
ln -sf $dotfiles/zsh/.zlogin $homedir/.zlogin

#ln -sf $dotfiles/fish/config.fish $homedir/.config/fish/config.fish
#ln -sf $dotfiles/fish/functions/fish_prompt.fish $homedir/.config/fish/functions/fish_prompt.fish

sudo touch /etc/NetworkManager/dispatcher.d/99-wlan
touch $
sudo ln -sf $dotfiles/scripts/wlan-on /etc/NetworkManager/dispatcher.d/99-wlan
sudo ln -sf $dotfiles/ranger/rc.conf $rootdir/.config/ranger/rc.conf
sudo ln -sf $dotfiles/ranger/rifle.conf $homedir/.config/ranger/rifle.conf
sudo ln -sf $dotfiles/zsh/.zshrc $rootdir/.zshrc
sudo ln -sf $dotfiles/vim/init.vim $rootdir/.vimrc
sudo ln -sf $dotfiles/.resolv.conf	/etc/resolv.conf

sudo sh -c "if [ -d $rootdir/dotfiles ]; then sudo rm -rf $rootdir/dotfiles; fi"
sudo ln -s $dotfiles $rootdir/dotfiles


echo "export DOTFILES=$dotfiles" > $dotfiles/zsh/dotfiles.zsh
echo "export HOMEDIR=$homedir" >> $dotfiles/zsh/dotfiles.zsh