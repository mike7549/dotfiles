[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec nvidia-xrun i3 -c ~/dotfiles/i3/config
