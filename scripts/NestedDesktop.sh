#!/bin/bash
set -euo pipefail

if [ $# -eq 0 ]; then
    echo "Usage: $(basename "$0") <command> [args...]" >&2
    exit 1
fi

if ! command -v kwin_wayland >/dev/null 2>&1; then
    echo "kwin_wayland not found" >&2
    exit 1
fi

WIDTH="${NESTED_WIDTH:-1280}"
HEIGHT="${NESTED_HEIGHT:-800}"

unset LD_PRELOAD

printf -v SESSION_CMD '%q ' "$@"

exec kwin_wayland \
    --xwayland \
    --no-lockscreen \
    --width "$WIDTH" \
    --height "$HEIGHT" \
    --exit-with-session "$SESSION_CMD"
