#!/bin/bash

source "$CONFIG_DIR/colors.sh"

FONT="SF Pro"

network_down=(
  padding_left=0.8
  y_offset=-7
  width=75
  label.font="$FONT:Heavy:10.0"
  label.color="$WHITE"
  icon=􀄩
  icon.font="$FONT:Bold:12.0"
  icon.color="$GREEN"
  icon.highlight_color="$BLUE"
  update_freq=2
)

network_up=(
  padding_left=-75
  y_offset=7
  width=0
  label.font="$FONT:Heavy:10.0"
  label.color="$WHITE"
  icon=􀄨
  icon.font="$FONT:Bold:12.0"
  icon.color="$BLUE"
  icon.highlight_color="$GREEN"
  update_freq=2
  script="$PLUGIN_DIR/network.sh"
)

sketchybar --add item network.down left \
  --set network.down "${network_down[@]}" \
  --add item network.up left \
  --set network.up "${network_up[@]}"
