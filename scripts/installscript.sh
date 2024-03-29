#!/bin/bash

# set dotfiles directory
dotdir="$HOME/dotfiles"
# update System before starting
sudo pacman -Syu wget base-devel

# yay
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd .. && rm -rf yay-bin

# install all the dotfile dependecies
yay -S $(cat $dotdir/scripts/packages)  --answerclean All --answerdiff All --answeredit All

# nvim install
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -u $dotdir/vim/init.vim -c :PlugInstall -c :q -c :q
sudo nvim -u $dotdir/vim/init.vim -c :PlugInstall -c :q -c :q

# detect sensors
yes | sudo sensors-detect

sudo fc-cache -f -v

# oh-my-zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
curl -L git.io/antigen > $HOME/.antigen.zsh

sudo chsh -s /usr/bin/zsh
chsh -s /usr/bin/zsh

# create symlinks
sh $dotdir/scripts/createSymlinks.sh

# change colors
dircolors -p > $HOME/.dircolors
