#!/bin/bash

# Add input source change event
sketchybar --add event input_source_change "AppleSelectedInputSourcesChangedNotification"

input_source=(
  script="$PLUGIN_DIR/input_source.sh"
  icon.drawing=off
  label="EN"
  label.font="$FONT:Bold:14.0"
  label.color="$WHITE"
  label.padding_left=3
  label.padding_right=5
  padding_left=5
  padding_right=5
  update_freq=2
)

sketchybar --add item input_source right \
  --set input_source "${input_source[@]}" \
  --subscribe input_source input_source_change
