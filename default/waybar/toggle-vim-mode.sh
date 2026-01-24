#!/bin/bash

STATE_FILE="/tmp/my-toggle"

# Create the file if it doesn't exist
if [ ! -f "$STATE_FILE" ]; then
  echo "N" > "$STATE_FILE"
fi

if [ -n "$1" ]; then
  echo "$1" > "$STATE_FILE"
  killall -SIGRTMIN+1 waybar
fi

STATE=$(cat "$STATE_FILE" 2>/dev/null)
if [ "$STATE" = "VI" ]; then
  echo '{"text": "VI"}'
else
  echo '{"text": ""}'
fi
