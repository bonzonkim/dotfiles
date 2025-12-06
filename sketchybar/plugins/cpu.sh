#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Get CPU usage percentage
CPU_USAGE=$(top -l 2 -n 0 -F | grep "CPU usage" | tail -1 | awk '{print $3}' | sed 's/%//')

# Round to integer
CPU_INT=$(printf "%.0f" "$CPU_USAGE")

# Set color based on usage
if [ "$CPU_INT" -gt 80 ]; then
    COLOR=$RED
elif [ "$CPU_INT" -gt 50 ]; then
    COLOR=$ORANGE
else
    COLOR=$WHITE
fi

sketchybar --set "$NAME" label="${CPU_INT}%" label.color="$COLOR"