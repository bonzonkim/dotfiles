#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Get memory info using vm_stat
VM_STAT=$(vm_stat)
PAGES_FREE=$(echo "$VM_STAT" | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
PAGES_ACTIVE=$(echo "$VM_STAT" | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
PAGES_INACTIVE=$(echo "$VM_STAT" | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
PAGES_WIRED=$(echo "$VM_STAT" | grep "Pages wired" | awk '{print $4}' | sed 's/\.//')
PAGES_COMPRESSED=$(echo "$VM_STAT" | grep "Pages compressed" | awk '{print $3}' | sed 's/\.//')

# Calculate used memory in GB (page size is 4096 bytes)
USED_PAGES=$((PAGES_ACTIVE + PAGES_WIRED + PAGES_COMPRESSED))
USED_GB=$(echo "scale=1; $USED_PAGES * 4096 / 1024 / 1024 / 1024" | bc)

# Get total memory
TOTAL_GB=$(sysctl -n hw.memsize | awk '{print $1/1024/1024/1024}')

# Calculate percentage
PERCENTAGE=$(echo "scale=0; $USED_GB / $TOTAL_GB * 100" | bc)

sketchybar --set "$NAME" label="${USED_GB}GB" label.color="$WHITE"