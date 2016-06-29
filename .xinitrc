xset -dpms s off
xset r rate 200 50
xrdb -load /home/michael/dotfiles/urxvt/Xresources
exec i3 -c /home/michael/dotfiles/i3/config
