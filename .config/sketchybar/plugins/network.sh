#!/bin/bash

# Auto-detect active network interface
INTERFACE=$(route -n get default 2>/dev/null | awk '/interface:/{print $2}')

# Fallback to first active ethernet-like interface
if [ -z "$INTERFACE" ]; then
  INTERFACE=$(ifconfig -l | tr ' ' '\n' | grep -E '^en' | head -1)
fi

# Read old stats
OLD_STATS=$(cat /tmp/network_stats 2>/dev/null || echo "0 0 $(date +%s)")
OLD_IN=$(echo "$OLD_STATS" | awk '{print $1}')
OLD_OUT=$(echo "$OLD_STATS" | awk '{print $2}')
OLD_TIME=$(echo "$OLD_STATS" | awk '{print $3}')

# Get current stats using interface-specific query
CURRENT_STATS=$(netstat -ibI "$INTERFACE" 2>/dev/null | awk 'NR==2{print $7" "$10}')

# Fallback to grep if interface-specific fails
if [ -z "$CURRENT_STATS" ]; then
  CURRENT_STATS=$(netstat -ib | grep "^${INTERFACE}" | awk '{print $7" "$10}' | head -1)
fi

CURRENT_IN=$(echo "$CURRENT_STATS" | awk '{print $1}')
CURRENT_OUT=$(echo "$CURRENT_STATS" | awk '{print $2}')
CURRENT_TIME=$(date +%s)

# Save current stats
echo "$CURRENT_IN $CURRENT_OUT $CURRENT_TIME" > /tmp/network_stats

# Calculate rates
TIME_DIFF=$((CURRENT_TIME - OLD_TIME))
[ $TIME_DIFF -eq 0 ] && TIME_DIFF=1

RATE_IN=$(( (CURRENT_IN - OLD_IN) / TIME_DIFF ))
RATE_OUT=$(( (CURRENT_OUT - OLD_OUT) / TIME_DIFF ))

# Handle negative rates (counter reset)
[ $RATE_IN -lt 0 ] && RATE_IN=0
[ $RATE_OUT -lt 0 ] && RATE_OUT=0

# Format function
format_rate() {
  local rate=$1
  if [ $rate -ge 1073741824 ]; then
    awk "BEGIN {printf \"%.1fG\", $rate / 1073741824}"
  elif [ $rate -ge 1048576 ]; then
    awk "BEGIN {printf \"%.1fM\", $rate / 1048576}"
  elif [ $rate -ge 1024 ]; then
    awk "BEGIN {printf \"%.0fK\", $rate / 1024}"
  else
    echo "${rate}B"
  fi
}

IN_FMT=$(format_rate $RATE_IN)
OUT_FMT=$(format_rate $RATE_OUT)

sketchybar --set "$NAME" label="↓${IN_FMT}/s ↑${OUT_FMT}/s"
