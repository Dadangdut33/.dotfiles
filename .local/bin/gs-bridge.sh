#!/bin/bash

# Usage: ./gs-bridge.sh --start [id]
# Usage: ./gs-bridge.sh --stop [id]
# Usage: ./gs-bridge.sh --kill-all
# Usage: ./gs-bridge.sh --status

# example:
# - ./gs-bridge.sh --start mygame
# - ./gs-bridge.sh --stop mygame

ACTION=$1
ID=${2:-"default"}
PID_DIR="/tmp/gs_bridges"
mkdir -p "$PID_DIR"
PID_FILE="$PID_DIR/$ID.pid"

get_target_display() {
    command ls /tmp/.X11-unix/ | grep -o 'X[0-9]\+' | sort -V | tail -n 1 | sed 's/X/:/'
}

case "$ACTION" in
    --start)
        # Check if already running for this ID
        if [ -f "$PID_FILE" ] && ps -p $(cat "$PID_FILE") > /dev/null; then
            echo "[-] Bridge for '$ID' is already running."
            exit 1
        fi

        sleep 5
        TARGET=$(get_target_display)

        if [[ -z "$TARGET" || "$TARGET" == ":0" ]]; then
            echo "[-] Error: No Gamescope display found."
            exit 1
        fi

        # We use 'exec' or a specific process group to track it better
        # Starting the bridge and saving the PID
        wl-paste --watch xclip -selection clipboard -display "$TARGET" &
        NEW_PID=$!
        echo $NEW_PID > "$PID_FILE"
        echo "[+] Bridge started for '$ID' on $TARGET (PID: $NEW_PID)"
        ;;

    --stop)
        if [ -f "$PID_FILE" ]; then
            PID=$(cat "$PID_FILE")
            # Kill the specific process AND its children
            pkill -P "$PID" 2>/dev/null
            kill "$PID" 2>/dev/null
            rm "$PID_FILE"
            echo "[+] Bridge for '$ID' stopped and cleaned up."
        else
            echo "[-] No PID file for '$ID'. Trying a manual search..."
            # Fallback: kill any wl-paste associated with a specific display if possible
            # But usually, the PID file is enough.
        fi
        ;;

    --kill-all)
        echo "[!] Killing ALL Gamescope clipboard bridges..."
        # This targets the specific command string to avoid killing other wl-paste instances
        pkill -f "wl-paste --watch xclip"
        rm -rf "$PID_DIR"/*.pid
        echo "[+] Done."
        ;;

    --status)
        echo "Active Gamescope Clipboard Bridges:"
        echo "-----------------------------------"
        count=0
        for f in "$PID_DIR"/*.pid; do
            [ -e "$f" ] || continue
            NAME=$(basename "$f" .pid)
            PID=$(cat "$f")
            if ps -p "$PID" > /dev/null; then
                echo "ID: $NAME | PID: $PID | Status: RUNNING"
                ((count++))
            else
                rm "$f"
            fi
        done
        [ $count -eq 0 ] && echo "No active bridges found."
        ;;

    *)
        echo "Usage: $0 {--start|--stop|--kill-all|--status} [id]"
        ;;
esac
