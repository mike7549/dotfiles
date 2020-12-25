#!/bin/bash

dotdir="/home/$USER/dotfiles"
#update System before starting
sudo pacman -Syu wget

#Yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

#install all the dotfile dependecies
yay -S $(cat $dotdir/packages)  --answerclean All --answerdiff All --answeredit All

#nvim install
sudo pip install neovim
sudo pip3 install neovim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -u $dotdir/vim/init.vim -c :PlugInstall -c :q -c :q
sudo nvim -u $dotdir/vim/init.vim -c :PlugInstall -c :q -c :q

#other installations
yes | sudo sensors-detect

sudo cp -r $dotdir/Hack/ /usr/share/fonts
sudo fc-cache

sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -L git.io/antigen > .antigen.zsh

sudo chsh -s /usr/bin/zsh
chsh -s /usr/bin/zsh

sh $dotdir/createSymlinks.sh

dircolors -p > ~/.dircolors
