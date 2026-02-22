#!/bin/bash

PID_FILE="/tmp/gamescope_clipboard_bridge.pid"

get_target_display() {
    # This ignores metadata/icons and only grabs the highest X number (e.g., :2)
    # 1. 'command ls' bypasses any fancy aliases
    # 2. 'grep -o' extracts ONLY the 'X' and digits
    # 3. 'sort -V' handles version-style sorting
    # 4. 'sed' converts 'X2' to ':2'
    command ls /tmp/.X11-unix/ | grep -o 'X[0-9]\+' | sort -V | tail -n 1 | sed 's/X/:/'
}

start_bridge() {
    # Give Gamescope 2 seconds to create the socket
    sleep 2
    
    TARGET_DISPLAY=$(get_target_display)

    if [[ -z "$TARGET_DISPLAY" || "$TARGET_DISPLAY" == ":0" ]]; then
        echo "Error: Could not find a valid Gamescope display (found $TARGET_DISPLAY)."
        exit 1
    fi

    echo "Bridging host clipboard to Gamescope display $TARGET_DISPLAY..."

    # Start the bridge in the background and save the PID
    # We use 'wl-paste --watch' to sync host -> game
    wl-paste --watch xclip -selection clipboard -display "$TARGET_DISPLAY" &
    echo $! > "$PID_FILE"
}

stop_bridge() {
    if [ -f "$PID_FILE" ]; then
        PID=$(cat "$PID_FILE")
        echo "Stopping clipboard bridge (PID $PID)..."
        kill "$PID" 2>/dev/null
        rm "$PID_FILE"
    else
        echo "No active bridge found to stop."
    fi
}

case "$1" in
    --start)
        start_bridge
        ;;
    --stop)
        stop_bridge
        ;;
    *)
        echo "Usage: $0 {--start|--stop}"
        exit 1
        ;;
esac