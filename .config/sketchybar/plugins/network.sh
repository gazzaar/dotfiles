#!/bin/bash
NAME="network"
INTERFACE="en5"  # Your active interface

# Read old stats
OLD_STATS=$(cat /tmp/network_stats 2>/dev/null || echo "0 0 $(date +%s)")
OLD_IN=$(echo "$OLD_STATS" | awk '{print $1}')
OLD_OUT=$(echo "$OLD_STATS" | awk '{print $2}')
OLD_TIME=$(echo "$OLD_STATS" | awk '{print $3}')

# Get current stats
CURRENT_STATS=$(netstat -ib | grep "^${INTERFACE}" | awk '{print $7" "$10}' | head -1)
CURRENT_IN=$(echo "$CURRENT_STATS" | awk '{print $1}')
CURRENT_OUT=$(echo "$CURRENT_STATS" | awk '{print $2}')
CURRENT_TIME=$(date +%s)

# Save current stats with timestamp
echo "$CURRENT_IN $CURRENT_OUT $CURRENT_TIME" > /tmp/network_stats

# Calculate time difference
TIME_DIFF=$((CURRENT_TIME - OLD_TIME))
if [ $TIME_DIFF -eq 0 ]; then
  TIME_DIFF=1  # Avoid division by zero
fi

# Calculate rates (bytes per second)
RATE_IN=$(( (CURRENT_IN - OLD_IN) / TIME_DIFF ))
RATE_OUT=$(( (CURRENT_OUT - OLD_OUT) / TIME_DIFF ))

# Handle negative rates (counter reset)
[ $RATE_IN -lt 0 ] && RATE_IN=0
[ $RATE_OUT -lt 0 ] && RATE_OUT=0

# Format function with proper thresholds
format_rate() {
  local rate=$1
  if [ $rate -ge 1073741824 ]; then
    # >= 1GB
    awk "BEGIN {printf \"%.1fG\", $rate / 1073741824}"
  elif [ $rate -ge 1048576 ]; then
    # >= 1MB
    awk "BEGIN {printf \"%.1fM\", $rate / 1048576}"
  elif [ $rate -ge 1024 ]; then
    # >= 1KB
    awk "BEGIN {printf \"%.0fK\", $rate / 1024}"
  else
    # < 1KB
    echo "${rate}B"
  fi
}

IN_FMT=$(format_rate $RATE_IN)
OUT_FMT=$(format_rate $RATE_OUT)

sketchybar --set "$NAME" label="↓${IN_FMT}/s ↑${OUT_FMT}/s"
