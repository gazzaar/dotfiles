#!/bin/bash

sketchybar --add item network right \
           --set network update_freq=1 \
                        icon=􀇄 \
                        script="$PLUGIN_DIR/network.sh"
