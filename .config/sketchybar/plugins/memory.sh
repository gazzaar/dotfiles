#!/bin/bash
NAME="memory"

# Get memory info
MEM_INFO=$(vm_stat)

# Parse memory values
FREE_MEM=$(echo "$MEM_INFO" | awk '/Pages free/ {print $3}' | tr -d '.')
INACTIVE_MEM=$(echo "$MEM_INFO" | awk '/Pages inactive/ {print $3}' | tr -d '.')
SPECULATIVE_MEM=$(echo "$MEM_INFO" | awk '/Pages speculative/ {print $3}' | tr -d '.')
PURGEABLE_MEM=$(echo "$MEM_INFO" | awk '/Pages purgeable/ {print $3}' | tr -d '.')

# Get total memory and DYNAMIC page size
TOTAL_MEM=$(sysctl -n hw.memsize)
PAGE_SIZE=$(vm_stat | head -1 | awk '{print $8}' | tr -d '.')

# Convert pages to bytes
FREE_MEM=$((FREE_MEM * PAGE_SIZE))
INACTIVE_MEM=$((INACTIVE_MEM * PAGE_SIZE))
SPECULATIVE_MEM=$((SPECULATIVE_MEM * PAGE_SIZE))
PURGEABLE_MEM=$((PURGEABLE_MEM * PAGE_SIZE))

# Calculate available and used memory
AVAILABLE_MEM=$((FREE_MEM + INACTIVE_MEM + SPECULATIVE_MEM + PURGEABLE_MEM))
USED_MEM=$((TOTAL_MEM - AVAILABLE_MEM))

# Calculate percentage
if [ "$TOTAL_MEM" -gt 0 ]; then
  MEM_PERCENT=$(awk "BEGIN {printf \"%.0f\", ($USED_MEM * 100 / $TOTAL_MEM)}")
else
  MEM_PERCENT=0
fi

sketchybar --set "$NAME" label="${MEM_PERCENT}%"
