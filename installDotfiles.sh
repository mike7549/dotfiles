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
ln -sf $dotfiles/xorg/xinitrc $homedir/.xinitrc
ln -sf $dotfiles/config/compton.conf $homedir/.compton.conf
ln -sf $dotfiles/termite/config $homedir/.config/termite/config
ln -sf $dotfiles/i3/i3blocks.conf $homedir/.i3blocks.conf
mkdir -p .config/networkmanager-dmenu/ && ln -sf $dotfiles/config/network_dmenu.conf $homedir/.config/networkmanager-dmenu/config.ini
ln -sf $dotfiles/zsh/zshrc $homedir/.zshrc
ln -sf $dotfiles/zsh/zlogin $homedir/.zlogin

sudo ln -sf $dotfiles/ranger/rc.conf $rootdir/.config/ranger/rc.conf
sudo ln -sf $dotfiles/ranger/rifle.conf $rootdir/.config/ranger/rifle.conf
sudo ln -sf $dotfiles/zsh/.zshrc $rootdir/.zshrc
sudo ln -sf $dotfiles/vim/init.vim $rootdir/.vimrc

sudo sh -c "if [ -d $rootdir/dotfiles ]; then sudo rm -rf $rootdir/dotfiles; fi"
sudo ln -s $dotfiles $rootdir/dotfiles

echo "export DOTFILES=$dotfiles" > $dotfiles/zsh/dotfiles.zsh
echo "export HOMEDIR=$homedir" > $dotfiles/zsh/dotfiles.zsh
