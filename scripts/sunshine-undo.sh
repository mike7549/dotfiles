#!/usr/bin/bash
set -euo pipefail

 
LOG_FILE="/tmp/sunshine-undo.log"
 
log() { echo "[$(date '+%H:%M:%S')] $*" | tee -a "$LOG_FILE"; }
 
log "=== Sunshine undo started ==="
 
# ---------------------------------------------------------------------------
# Discover displays
# ---------------------------------------------------------------------------
ALL_OUTPUTS=$(kscreen-doctor -o | grep Output | awk -F' ' '{print $3}')
 
if [[ -z "$ALL_OUTPUTS" ]]; then
    log "ERROR: kscreen-doctor returned no outputs."
    exit 1
fi

DUMMY_OUTPUT=$(echo "$ALL_OUTPUTS" | grep -i "HDMI" | head -n1)
DP_OUTPUTS=$(echo "$ALL_OUTPUTS" | grep -iv "HDMI")
 
log "Dummy output to disable: $DUMMY_OUTPUT"
log "DisplayPort outputs to restore: $(echo "$DP_OUTPUTS" | tr '\n' ' ')"
 
# ---------------------------------------------------------------------------
# Build and run the kscreen-doctor command
# ---------------------------------------------------------------------------
ARGS=()
 
while IFS= read -r name; do
    log "Re-enabling: $name"
    ARGS+=("output.${name}.enable")

done <<< "$DP_OUTPUTS"
 
if [[ -n "$DUMMY_OUTPUT" ]]; then
    log "Disabling dummy: $DUMMY_OUTPUT"
    ARGS+=("output.${DUMMY_OUTPUT}.disable")
fi
 
log "Running: kscreen-doctor ${ARGS[*]}"
kscreen-doctor "${ARGS[@]}" 2>&1 | tee -a "$LOG_FILE"
 
log "Undo complete — normal display layout restored."