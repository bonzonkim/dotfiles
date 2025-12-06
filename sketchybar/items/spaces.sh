#!/bin/bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  
  space=(
    associated_space=$sid
    icon="${SPACE_ICONS[i]}"
    icon.padding_left=10
    icon.padding_right=10
    icon.highlight_color=$WHITE
    background.color=$BACKGROUND_1
    background.border_color=$BACKGROUND_2
    background.border_width=1
    background.corner_radius=8
    background.height=26
    background.drawing=off
    label.drawing=off
    script="$PLUGIN_DIR/space.sh"
    click_script="yabai -m space --focus $sid"
  )
  
  sketchybar --add space space.$sid left \
    --set space.$sid "${space[@]}" \
    --subscribe space.$sid space_change
done

spaces_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  background.border_width=1
  background.corner_radius=8
  background.height=30
  background.drawing=on
)

separator=(
  icon="􀆊"
  icon.font="$FONT:Heavy:16.0"
  padding_left=10
  padding_right=8
  label.drawing=off
  associated_display=active
  click_script='yabai -m space --create && sketchybar --trigger space_change'
  icon.color=$WHITE
)

sketchybar --add item separator left \
  --set separator "${separator[@]}"

# Add bracket for spaces
sketchybar --add bracket spaces '/space\..*/' separator \
  --set spaces "${spaces_bracket[@]}"