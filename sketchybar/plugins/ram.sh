#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Get page size dynamically (16384 on M1/M2, 4096 on Intel)
PAGE_SIZE=$(pagesize)

# Get memory info using vm_stat
VM_STAT=$(vm_stat)
PAGES_ACTIVE=$(echo "$VM_STAT" | grep "Pages active" | awk '{print $3}' | tr -d '.')
PAGES_WIRED=$(echo "$VM_STAT" | grep "Pages wired down" | awk '{print $4}' | tr -d '.')
PAGES_COMPRESSOR=$(echo "$VM_STAT" | grep "Pages occupied by compressor" | awk '{print $5}' | tr -d '.')

# Get total memory
TOTAL_BYTES=$(sysctl -n hw.memsize)
TOTAL_PAGES=$((TOTAL_BYTES / PAGE_SIZE))

# Calculate used memory (Active + Wired + Compressor) - matches RunCat/Activity Monitor
USED_PAGES=$((PAGES_ACTIVE + PAGES_WIRED + PAGES_COMPRESSOR))

# Calculate percentage
PERCENTAGE=$((USED_PAGES * 100 / TOTAL_PAGES))

sketchybar --set "$NAME" label="${PERCENTAGE}%" label.color="$WHITE"