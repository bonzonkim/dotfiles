#!/bin/bash

temp=(
  script="$PLUGIN_DIR/temp.sh"
  icon="$CPU"
  icon.padding_right=0
  padding_right=0
  padding_left=3
  label=" Temp Unknown"
  label.drawing=on
  label.padding_right=5
  update_freq=10
)

sketchybar --add item temp left \
  --set temp "${temp[@]}"
