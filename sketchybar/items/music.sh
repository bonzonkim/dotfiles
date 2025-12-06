#!/bin/bash

music=(
  script="$PLUGIN_DIR/music.sh"
  label.padding_right=8
  label.font="$FONT:Regular:13.0"
  padding_right=16
  icon="􀊆"
  icon.font="$FONT:Regular:16.0"
  drawing=on  # Always show by default
  label=""
  scroll_texts=on
  icon.padding_left=8
  label.max_chars=25
  label.align=left
  update_freq=5  # Check more frequently for Spotify
  click_script="open -a Spotify"  # Open Spotify app when clicked
  --subscribe music media_change system_woke
)

sketchybar \
  --add item music right \
  --set music "${music[@]}"
