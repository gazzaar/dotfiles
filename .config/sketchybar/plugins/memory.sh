#!/bin/bash

NAME="memory"

# Get memory information
MEM_INFO=$(vm_stat)

# Extract memory statistics (values are in pages)
FREE_MEM=$(echo "$MEM_INFO" | awk '/Pages free/ {print $3}' | tr -d '.')
INACTIVE_MEM=$(echo "$MEM_INFO" | awk '/Pages inactive/ {print $3}' | tr -d '.')
SPECULATIVE_MEM=$(echo "$MEM_INFO" | awk '/Pages speculative/ {print $3}' | tr -d '.')
CACHED_FILES_MEM=$(echo "$MEM_INFO" | awk '/Pages purgeable/ {print $3}' | tr -d '.')

# Get total physical memory
TOTAL_MEM=$(sysctl -n hw.memsize)

# Convert pages to bytes (each page is 4096 bytes)
PAGE_SIZE=4096
FREE_MEM=$((FREE_MEM * PAGE_SIZE))
INACTIVE_MEM=$((INACTIVE_MEM * PAGE_SIZE))
SPECULATIVE_MEM=$((SPECULATIVE_MEM * PAGE_SIZE))
CACHED_FILES_MEM=$((CACHED_FILES_MEM * PAGE_SIZE))

# Calculate total available memory
AVAILABLE_MEM=$((FREE_MEM + INACTIVE_MEM + SPECULATIVE_MEM + CACHED_FILES_MEM))

# Calculate percentage of available memory
if [ "$TOTAL_MEM" -gt 0 ]; then
  MEM_PERCENT=$(echo "scale=2; $AVAILABLE_MEM * 100 / $TOTAL_MEM" | bc)
  # Round to nearest integer
  MEM_PERCENT=$(printf "%.0f" "$MEM_PERCENT")
else
  MEM_PERCENT=0
fi

# Update label on sketchybar
sketchybar --set "$NAME" label="${MEM_PERCENT}%"
