#!/bin/bash

# Get memory info
MEM_INFO=$(vm_stat)

# Parse page size from first line
PAGE_SIZE=$(echo "$MEM_INFO" | head -1 | grep -o '[0-9]\+' | tail -1)
PAGE_SIZE=${PAGE_SIZE:-16384}

# Parse memory pages (remove trailing dots)
FREE_PAGES=$(echo "$MEM_INFO" | awk '/Pages free/ {print $3}' | sed 's/\.//')
ACTIVE_PAGES=$(echo "$MEM_INFO" | awk '/Pages active/ {print $3}' | sed 's/\.//')
INACTIVE_PAGES=$(echo "$MEM_INFO" | awk '/Pages inactive/ {print $3}' | sed 's/\.//')
SPECULATIVE_PAGES=$(echo "$MEM_INFO" | awk '/Pages speculative/ {print $3}' | sed 's/\.//')
WIRED_PAGES=$(echo "$MEM_INFO" | awk '/Pages wired down/ {print $4}' | sed 's/\.//')
COMPRESSED_PAGES=$(echo "$MEM_INFO" | awk '/Pages occupied by compressor/ {print $5}' | sed 's/\.//')

# Handle empty values
FREE_PAGES=${FREE_PAGES:-0}
ACTIVE_PAGES=${ACTIVE_PAGES:-0}
INACTIVE_PAGES=${INACTIVE_PAGES:-0}
SPECULATIVE_PAGES=${SPECULATIVE_PAGES:-0}
WIRED_PAGES=${WIRED_PAGES:-0}
COMPRESSED_PAGES=${COMPRESSED_PAGES:-0}

# Calculate used memory (active + wired + compressed)
USED_PAGES=$((ACTIVE_PAGES + WIRED_PAGES + COMPRESSED_PAGES))
TOTAL_PAGES=$((FREE_PAGES + ACTIVE_PAGES + INACTIVE_PAGES + SPECULATIVE_PAGES + WIRED_PAGES + COMPRESSED_PAGES))

# Calculate percentage
if [ "$TOTAL_PAGES" -gt 0 ]; then
  MEM_PERCENT=$(awk "BEGIN {printf \"%.0f\", ($USED_PAGES * 100 / $TOTAL_PAGES)}")
else
  MEM_PERCENT=0
fi

sketchybar --set "$NAME" label="${MEM_PERCENT}%"
