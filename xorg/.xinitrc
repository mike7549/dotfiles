xset -dpms s off
xset r rate 200 50
xrdb -load $DOTFILES/xorg/Xresources
exec i3 -c $DOTFILES/i3/config
LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so' /usr/bin/steam

