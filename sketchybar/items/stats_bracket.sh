#!/bin/bash

# Create a bracket for left side system stats
stats_bracket=(
  background.color="$BACKGROUND_1"
  background.border_color="$BACKGROUND_2"
  background.border_width=1
  background.height=30
  background.corner_radius=8
  background.drawing=on
)

# Add bracket after all items are created
sketchybar --add bracket stats cpu temp ram \
  --set stats "${stats_bracket[@]}"