#!/bin/bash

ram=(
  script="$PLUGIN_DIR/ram.sh"
  icon="$RAM"
  icon.padding_right=0
  padding_right=0
  padding_left=10
  label="RAM"
  label.drawing=on
  label.padding_right=5
  update_freq=10
)

sketchybar --add item ram left \
  --set ram "${ram[@]}"
