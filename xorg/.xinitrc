xset -dpms s off
xset r rate 200 50
xrandr --dpi 220
xrdb -load $DOTFILES/xorg/Xresources
exec i3 -c $DOTFILES/i3/config
