#!/bin/bash

cpu=(
  script="$PLUGIN_DIR/cpu.sh"
  icon=":cpu:"
  icon.font="sketchybar-app-font:Regular:15.0"
  icon.font.size=15.0
  icon.padding_right=0
  padding_right=5
  padding_left=5
  label="CPU"
  label.drawing=on
  label.padding_right=5
  update_freq=5
)

sketchybar --add item cpu left \
  --set cpu "${cpu[@]}"