#!/bin/bash
# /lib/systemd/system-sleep/sunshine-sleep-hook
# Restores normal display layout before the PC sleeps/hibernates.

case "$1" in
    pre)
        sunshine-undo
        ;;
esac
