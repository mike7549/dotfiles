#!/bin/bash
unset LD_PRELOAD
unset XDG_DESKTOP_PORTAL_DIR
unset XDG_SEAT_PATH
unset XDG_SESSION_PATH
RES=$(xdpyinfo | awk '/dimensions/{print $2}')

mkdir $XDG_RUNTIME_DIR/nested_kde -p
cat <<EOF > $XDG_RUNTIME_DIR/nested_kde/kwin_wayland_wrapper
#!/bin/sh
/usr/bin/kwin_wayland_wrapper \
  --width $(echo "$RES" | cut -d 'x' -f 1) \
  --height $(echo "$RES" | cut -d 'x' -f 2) \
  --no-lockscreen \
  \$@
EOF
chmod a+x $XDG_RUNTIME_DIR/nested_kde/kwin_wayland_wrapper
export PATH=$XDG_RUNTIME_DIR/nested_kde:$PATH

export XKB_DEFAULT_LAYOUT=de
export XKB_DEFAULT_MODEL=pc105
export XKB_DEFAULT_VARIANT=nodeadkeys

dbus-run-session startplasma-wayland &
PLASMA_PID=$!

# Wait for KWin to be ready, then apply focus settings via dbus
sleep 5
KWIN_DBUS=$(dbus-send --session --print-reply --dest=org.kde.KWin /KWin org.kde.KWin.supportInformation 2>/dev/null)
if [ -n "$KWIN_DBUS" ]; then
  dbus-send --session --dest=org.kde.KWin /KWin org.kde.KWin.reconfigure
fi

wait $PLASMA_PID
rm -f $XDG_RUNTIME_DIR/nested_kde/kwin_wayland_wrapper