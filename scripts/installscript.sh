#!/bin/bash

# set dotfiles directory
dotdir="$HOME/dotfiles"
# update System before starting
sudo pacman -Syu wget

# yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# install all the dotfile dependecies
yay -S $(cat $dotdir/scripts/packages)  --answerclean All --answerdiff All --answeredit All

# nvim install
sudo pip install neovim
sudo pip3 install neovim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -u $dotdir/vim/init.vim -c :PlugInstall -c :q -c :q
sudo nvim -u $dotdir/vim/init.vim -c :PlugInstall -c :q -c :q

# detect sensors
yes | sudo sensors-detect

# install nerd fonts
curl -L https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip > hack.zip
sudo unzip hack.zip -d /usr/share/fonts
rm hack.zip
sudo fc-cache -f -v

# oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -L git.io/antigen > .antigen.zsh

sudo chsh -s /usr/bin/zsh
chsh -s /usr/bin/zsh

# create symlinks
sh $dotdir/scripts/createSymlinks.sh

# change colors
dircolors -p > ~/.dircolors
