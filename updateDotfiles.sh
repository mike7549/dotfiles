#!/bin/bash

ln -sf /home/michael/dotfiles/vim/.vimrc ~/.vimrc
ln -sf /home/michael/dotfiles/i3/config ~/.i3/config 
ln -sf /home/michael/dotfiles/i3/i3blocks.conf ~/.i3blocks.conf
sudo ln -sf /home/michael/dotfiles/i3/i3status.conf /etc/i3status.conf
ln -sf /home/michael/dotfiles/ranger/ /home/michael/.config/
ln -sf /home/michael/dotfiles/urxvt/Xresources /home/michael/.Xresources
ln -sf /home/michael/dotfiles/urxvt/Xdefaults /home/michael/.Xdefaults
ln -sf /home/michael/dotfiles/fish/config.fish /home/michael/.config/fish/config.fish
ln -sf /home/michael/dotfiles/.bashrc /home/michael/.bashrc
ln -sf /home/michael/dotfiles/.xinitrc /home/michael/.xinitrc
ln -sf /home/michael/dotfiles/termite/config /home/michael/.config/termite/config
sudo ln -sf /home/michael/dotfiles/slim/slim.conf /etc/slim.conf
ln -sf /home/michael/dotfiles/fish/functions/fish_prompt.fish /home/michael/.config/fish/functions/fish_prompt.fish
ln -sf /home/michael/dotfiles/gtk/settings.ini /home/michael/.config/gtk-3.0/settings.ini
ln -sf /home/michael/dotfiles/.dircolors /home/michael/.dircolors
ln -sf /home/michael/dotfiles/vim /home/michael/.config/nvim
ln -sf /home/michael/dotfiles/.compton.conf /home/michael/.compton.conf
sudo ln -sf /home/michael/dotfiles/.20-intel.conf /etc/X11/xorg.conf.d/20-intel.conf
sudo ln -sf /home/michael/dotfiles/scripts/wlan-on /etc/NetworkManager/dispatcher.d/99-wlan
