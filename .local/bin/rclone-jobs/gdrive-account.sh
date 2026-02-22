#!/bin/sh
/usr/bin/rclone bisync name: /path/to/stored \
  --exclude "desktop.ini" \
  --exclude "Thumbs.db" \
  --exclude "$RECYCLE.BIN/**" \
  --exclude "System Volume Information/**" \
  --progress
