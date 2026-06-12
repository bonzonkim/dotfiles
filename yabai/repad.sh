#!/usr/bin/env bash
# Re-apply per-display top padding. Invoked by yabai signals on display/space
# changes. Kept standalone so signal actions don't re-source the whole yabairc
# (which would re-register signals + rules and stack them on every wake).
#
# macOS only reserves the menu-bar strip on the MAIN display, so windows there
# already clear sketchybar with a small pad. External displays get no such
# reservation, so they must pad by the full bar height (height 30 + y_offset 6
# ~= 36, plus buffer).

MAIN_TOP=6
EXTERNAL_TOP=40

yabai -m query --displays | jq -c '.[]' | while read -r display; do
  id=$(echo "$display" | jq -r '.id')
  x=$(echo "$display" | jq -r '.frame.x | floor')
  y=$(echo "$display" | jq -r '.frame.y | floor')

  # Main display is the one whose frame origin is (0,0).
  if [ "$x" -eq 0 ] && [ "$y" -eq 0 ]; then
    top_padding=$MAIN_TOP
  else
    top_padding=$EXTERNAL_TOP
  fi

  yabai -m config --display "$id" top_padding "$top_padding"

  yabai -m query --spaces --display "$id" | jq -r '.[].index' | while read -r space; do
    yabai -m config --space "$space" top_padding "$top_padding"
  done
done
