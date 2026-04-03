#!/usr/bin/bash
set -euo pipefail

LOG_FILE="/tmp/sunshine-prep.log"
log() { echo "[$(date '+%H:%M:%S')] $*" | tee -a "$LOG_FILE"; }

# set dummy output to first HDMI found
DUMMY_OUTPUT=$(kscreen-doctor -o | grep Output | awk -F' ' '{print $3}' | grep -i "HDMI" | head -n1)

log "Dummy output identified: $DUMMY_OUTPUT"


# Fall back to sane defaults if Sunshine didn't export these
WIDTH="${SUNSHINE_CLIENT_WIDTH:-1920}"
HEIGHT="${SUNSHINE_CLIENT_HEIGHT:-1080}"
FPS="${SUNSHINE_CLIENT_FPS:-60}"



log "=== Sunshine prep started ==="
log "Requested resolution: ${WIDTH}x${HEIGHT}@${FPS}"

OUTPUTS=$(kscreen-doctor -o | grep Output | awk -F' ' '{print $3}' | grep -iv "HDMI")

if [[ -z "$OUTPUTS" ]]; then
    log "ERROR: kscreen-doctor returned no outputs. Is kscreen installed?"
    exit 1
fi

log "Detected outputs: $(echo "$OUTPUTS" | tr '\n' ' ')"

ARGS=()

# Enable the dummy display and set the requested mode
ARGS+=("output.${DUMMY_OUTPUT}.enable")
ARGS+=("output.${DUMMY_OUTPUT}.mode.${WIDTH}x${HEIGHT}@${FPS}")
ARGS+=("output.${DUMMY_OUTPUT}.position.0,0")

# Disable every other output
while IFS= read -r name; do
    log "Disabling output: $name"
    ARGS+=("output.${name}.disable")
done <<< "$OUTPUTS"

log "Running: kscreen-doctor ${ARGS[*]}"
kscreen-doctor "${ARGS[@]}" 2>&1 | tee -a "$LOG_FILE"

log "Prep complete — streaming on ${DUMMY_OUTPUT} at ${WIDTH}x${HEIGHT}@${FPS}"
