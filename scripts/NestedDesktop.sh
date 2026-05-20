#!/bin/bash
set -euo pipefail

COMPOSITOR="${NESTED_COMPOSITOR:-kwin}"
RESOLUTION="${NESTED_RES:-1280x800}"
LOG_DIR="${XDG_RUNTIME_DIR:-/tmp}/nested-desktop"
LOG_FILE="${LOG_DIR}/nested.log"
SOCKET_NAME="nested-wayland-$(date +%s)"

log()  { 
    echo "[nested-desktop] $*" | tee -a "$LOG_FILE"; 
}

die()  { 
    log "ERROR: $*"; exit 1; 
}

preflight() {
    mkdir -p "$LOG_DIR"
    log "=== Starting nested desktop ==="
    log "Compositor : $COMPOSITOR"
    log "Resolution : $RESOLUTION"
    log "Socket     : $SOCKET_NAME"

    [[ -n "${WAYLAND_DISPLAY:-}" ]] || \
        die "No WAYLAND_DISPLAY found."
}

launch_kwin() {
    log "Launching KWin Wayland nested session..."

    local W H
    W="${RESOLUTION%%x*}"
    H="${RESOLUTION##*x}"

    local socket_path="${XDG_RUNTIME_DIR}/${SOCKET_NAME}"

    # Run kwin and plasmashell in the same dbus session, but started separately
    # so plasmashell connects to the nested compositor rather than spawning its own kwin.
    dbus-run-session -- bash -c "
        kwin_wayland \
            --wayland-display '${WAYLAND_DISPLAY}' \
            --width  '${W}' \
            --height '${H}' \
            --socket '${SOCKET_NAME}' &
        kwin_pid=\$!
        for i in \$(seq 40); do
            [ -S '${socket_path}' ] && break
            sleep 0.25
        done
        WAYLAND_DISPLAY='${SOCKET_NAME}' plasmashell &
        wait \$kwin_pid
    " >> "$LOG_FILE" 2>&1 &

    NESTED_PID=$!
    log "Nested session PID: $NESTED_PID"
    log "Child apps should use: WAYLAND_DISPLAY=${socket_path}"
}

launch_cage() {
    local app="${CAGE_APP:-alacritty}"
    log "Launching cage (kiosk) with app: $app"

    WLR_BACKENDS=wayland \
    WAYLAND_DISPLAY="${WAYLAND_DISPLAY}" \
    cage -d -- "$app" \
        >> "$LOG_FILE" 2>&1 &

    NESTED_PID=$!
    log "cage PID: $NESTED_PID"
}

cleanup() {
    log "Caught exit signal. Stopping nested session (PID: ${NESTED_PID:-unknown})..."
    [[ -n "${NESTED_PID:-}" ]] && kill "$NESTED_PID" 2>/dev/null || true
    log "Done."
}
trap cleanup EXIT INT TERM

while [[ $# -gt 0 ]]; do
    case "$1" in
        -c|--compositor) COMPOSITOR="$2"; shift 2 ;;
        -r|--resolution) RESOLUTION="$2"; shift 2 ;;
        --cage-app)      CAGE_APP="$2"; shift 2 ;;
        -h|--help)
            cat <<'HELP'
Usage: nested-desktop.sh [OPTIONS]

Options:
  -c, --compositor <name>   Compositor to nest: kwin, cage
  -r, --resolution <WxH>    Virtual output resolution (default: 1280x800)
  -h, --help                Show this help

Environment variables:
  NESTED_COMPOSITOR         Same as --compositor
  NESTED_RES                Same as --resolution
  CAGE_APP                  App to launch when compositor=cage (default: alacritty)

Examples:
  # Nested KDE Plasma:
  ./nested-desktop.sh --compositor kwin

  # Kiosk-mode single app (Firefox):
  CAGE_APP=firefox ./nested-desktop.sh --compositor cage
  ./nested-desktop.sh --compositor cage --cage-app firefox
HELP
            exit 0 ;;
        *) die "Unknown option: $1. Use --help for usage." ;;
    esac
done

preflight

NESTED_PID=""

case "$COMPOSITOR" in
    kwin)  launch_kwin  ;;
    cage)  launch_cage  ;;
    *)     die "Unknown compositor '$COMPOSITOR'. Choose: kwin, cage" ;;
esac

# Wait for the nested compositor to exit
log "Nested desktop running. Waiting for PID $NESTED_PID to exit..."
wait "$NESTED_PID" || true
log "Nested desktop exited."