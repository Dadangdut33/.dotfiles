#!/bin/bash
set -e

DIR="$HOME/Pictures/Screenshots/$(date +%Y-%m)"
mkdir -p "$DIR"
FILE="$DIR/$(date +'%Y-%m-%d %H-%M-%S').png"

wayfreeze &
WAYFREEZE_PID=$!

cleanup() {
    kill "$WAYFREEZE_PID" 2>/dev/null || true
}
trap cleanup EXIT

sleep 0.1

GEOM=$(slurp)

# Take screenshot (still frozen)
grim -g "$GEOM" "$FILE"

# Unfreeze immediately
kill "$WAYFREEZE_PID"
trap - EXIT

# Launch editor correctly
satty --filename "$FILE" --copy-command "wl-copy" &
disown
