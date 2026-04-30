#!/bin/bash

CPU_USAGE=$(top -l 2 | grep "^CPU usage" | tail -1)
CPU_USER=$(echo "$CPU_USAGE" | awk '{print $3}' | sed 's/%//')
CPU_SYS=$(echo "$CPU_USAGE" | awk '{print $5}' | sed 's/%//')
CPU_PERCENT=$(echo "$CPU_USER + $CPU_SYS" | bc | awk '{printf "%.0f", $1}')

sketchybar --set $NAME label="$CPU_PERCENT%"
