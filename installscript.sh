#!/bin/bash

dotdir="/home/$USER/dotfiles"
#update System before starting
sudo pacman -Syu wget

#pacaur
git clone https://aur.archlinux.org/cower.git /tmp/cower
git clone https://aur.archlinux.org/pacaur.git /tmp/pacaur
cd /tmp/cower/
makepkg -s -i 
cd /tmp/pacaur/
makepkg -s -i 


#install all the dotfile dependecies
pacaur -S $(cat $dotdir/dependency.txt)

#zsh installation
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.config/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

rm ~/.zshrc

sh $dotdir/installDotfiles.sh

#vim
git clone https://github.com/VundleVim/Vundle.vim.git $dotdir/vim/bundle/Vundle.vim
vim -c :PluginInstall -c :q -c :q

sudo npm install -g typescript
cd ~/dotfiles/vim/bundle/YouCompleteMe
./install.py --all



#other installations
yes | sudo sensors-detect
sudo pip install i3ipc
sudo chsh -s /usr/bin/zsh

