#!/bin/bash

sketchybar --add item network right \
           --set network update_freq=2 \
                        icon=􀇄 \
                        script="$PLUGIN_DIR/network.sh"
