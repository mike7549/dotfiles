#!/bin/bash

sudo install -dm 555 "/etc/X11/xinit/nvidia-xinitrc.d"
sudo install -dm 555 "/etc/X11/xinit/nvidia-xorg.conf.d"
sudo install -Dm 755 ~/dotfiles/nvidia-xrun/nvidia-xrun "/usr/bin/nvidia-xrun"
sudo install -Dm 644 ~/dotfiles/nvidia-xrun/nvidia-xorg.conf "/etc/X11/nvidia-xorg.conf"
sudo install -Dm 644 ~/dotfiles/nvidia-xrun/nvidia-xinitrc "/etc/X11/xinit/nvidia-xinitrc"

