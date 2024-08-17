#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

if [ $SELECTED = true ]; then
  sketchybar --set $NAME background.drawing=on \
                         background.color=$SEPARATOR_COLOR\
                         label.color=$BACKGROUND_SPACE \
                         icon.color=$BACKGROUND_SPACE
else
  sketchybar --set $NAME background.drawing=off\
                          background.color=$BACKGROUND_SPACE\
                          label.color=$ITEMS_COLOR\
                         icon.color=$ITEMS_COLOR
fi
