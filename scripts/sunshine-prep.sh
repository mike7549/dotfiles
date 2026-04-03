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


# Returns all mode strings (e.g. "1920x1080@60.00") for the given output name
get_available_modes() {
    local output="$1"
    kscreen-doctor -o 2>/dev/null \
        | sed 's/\x1b\[[0-9;]*m//g' \
        | awk -v out="$output" '
            /^Output:/ { in_block = ($3 == out) }
            in_block && /Modes:/ { print }
        ' \
        | grep -oE '[0-9]+x[0-9]+@[0-9]+(\.[0-9]+)?[!*]?' \
        | sed 's/[!*]//' || true
}

# Returns the best available mode for the requested resolution/fps.
# Priority: exact match → same resolution closest fps → 1920x1080@60
find_best_mode() {
    local width="$1" 
    local height="$2"
    local fps="$3"
    local modes
    modes=$(get_available_modes "$DUMMY_OUTPUT")

    # Exact match (integer fps matches float, e.g. 60 matches 60.00)
    local exact
    exact=$(echo "$modes" | grep -E "^${width}x${height}@${fps}(\.[0-9]+)?$" | head -n1 || true)
    if [[ -n "$exact" ]]; then
        echo "$exact"
        return
    fi

    # Same resolution, pick mode with fps closest to requested
    local same_res
    same_res=$(echo "$modes" | grep -E "^${width}x${height}@" || true)
    if [[ -n "$same_res" ]]; then
        local best
        best=$(echo "$same_res" | awk -F@ -v target="$fps" '
            {
                f = $2 + 0
                diff = (f > target) ? f - target : target - f
                if (NR == 1 || diff < min_diff) { min_diff = diff; best = $0 }
            }
            END { print best }
        ')
        if [[ -n "$best" ]]; then
            echo "$best"
            return
        fi
    fi

    # Ultimate fallback
    echo "1920x1080@60"
}



# Resolve the mode, falling back if the exact one isn't available
# kscreen-doctor requires integer fps (e.g. 1280x800@60, not 1280x800@59.81)
MODE=$(find_best_mode "$WIDTH" "$HEIGHT" "$FPS" | awk -F'@' '{ printf "%s@%.0f", $1, $2 }')
#if [[ "$MODE" != "${WIDTH}x${HEIGHT}@${FPS}" && "$MODE" != "${WIDTH}x${HEIGHT}@${FPS}."* ]]; then
#    log "WARNING: mode ${WIDTH}x${HEIGHT}@${FPS} not found — using closest available: ${MODE}"
#fi
ARGS=()

# Enable the dummy display and set the requested mode
ARGS+=("output.${DUMMY_OUTPUT}.enable")
ARGS+=("output.${DUMMY_OUTPUT}.mode.${MODE}")
ARGS+=("output.${DUMMY_OUTPUT}.position.0,0")

# Disable every other output
while IFS= read -r name; do
    log "Disabling output: $name"
    ARGS+=("output.${name}.disable")
done <<< "$OUTPUTS"

log "Running: kscreen-doctor ${ARGS[*]}"
kscreen-doctor "${ARGS[@]}" 2>&1 | tee -a "$LOG_FILE"

log "Prep complete — streaming on ${DUMMY_OUTPUT} at ${MODE}"
