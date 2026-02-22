#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <name> [profile]"
    exit 1
fi

NAME="$1"
PROFILE="${2:-$1}"

$HOME/.local/bin/gs-bridge.sh --stop "$NAME" &
sleep 2
$HOME/.local/bin/customrpcmanager --disconnect
