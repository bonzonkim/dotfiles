#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Get page size dynamically (16384 on M1/M2, 4096 on Intel)
PAGE_SIZE=$(pagesize)

# Get memory info using vm_stat
VM_STAT=$(vm_stat)
PAGES_ACTIVE=$(echo "$VM_STAT" | grep "Pages active" | awk '{print $3}' | tr -d '.')
PAGES_WIRED=$(echo "$VM_STAT" | grep "Pages wired down" | awk '{print $4}' | tr -d '.')
PAGES_COMPRESSED=$(echo "$VM_STAT" | grep "Pages stored in compressor" | awk '{print $5}' | tr -d '.')

# Calculate used memory in bytes
USED_PAGES=$((PAGES_ACTIVE + PAGES_WIRED + PAGES_COMPRESSED))
USED_BYTES=$((USED_PAGES * PAGE_SIZE))

# Get total memory in bytes
TOTAL_BYTES=$(sysctl -n hw.memsize)

# Calculate percentage
PERCENTAGE=$((USED_BYTES * 100 / TOTAL_BYTES))

sketchybar --set "$NAME" label="${PERCENTAGE}%" label.color="$WHITE"