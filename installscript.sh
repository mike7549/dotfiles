#!/bin/bash

dotdir="/home/$USER/dotfiles"
#update System before starting
sudo pacman -Syu wget

#Yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

#install all the dotfile dependecies
yay -S $(cat $dotdir/dependency)  --answerclean N --answerdiff N --answeredit N 

#nvim install
sudo pip install neovim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -u $dotdir/vim/init.vim -c :PlugInstall -c :q -c :q
sudo nvim -u $dotdir/vim/init.vim -c :PlugInstall -c :q -c :q

#other installations
yes | sudo sensors-detect
sudo pip install i3ipc

sudo cp -r $dotdir/Hack/ /usr/share/fonts
sudo fc-cache

sudo chsh -s /usr/bin/zsh
chsh -s /usr/bin/zsh

sh $dotdir/installDotfiles.sh

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search

dircolors -p > ~/.dircolors
