#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Get current input source using a more reliable method
LAYOUT=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | plutil -convert json -o - - | jq -r '.[1].InputSourceKind // .[0].InputSourceKind')

# Check if it's Korean input
if defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep -q "com.apple.inputmethod.Korean"; then
  LABEL="한"
else
  LABEL="EN"
fi

sketchybar --set "$NAME" label="$LABEL" label.color="$WHITE"