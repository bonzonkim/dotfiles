#!/bin/bash

# If INFO is not set, try to get current playing info
if [ -z "$INFO" ]; then
  # Check if Spotify is running first
  if pgrep -x "Spotify" > /dev/null; then
    # Get Spotify info
    STATE=$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)
    
    if [ "$STATE" = "playing" ]; then
      TRACK=$(osascript -e 'tell application "Spotify" to name of current track' 2>/dev/null)
      ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track' 2>/dev/null)
      PLAYER_STATE="playing"
      CURRENT_SONG="$TRACK - $ARTIST"
    else
      PLAYER_STATE="paused"
      CURRENT_SONG=""
    fi
  # If Spotify is not running, check Music app
  elif pgrep -x "Music" > /dev/null; then
    STATE=$(osascript -e 'tell application "Music" to player state as string' 2>/dev/null)
    
    if [ "$STATE" = "playing" ]; then
      TRACK=$(osascript -e 'tell application "Music" to name of current track' 2>/dev/null)
      ARTIST=$(osascript -e 'tell application "Music" to artist of current track' 2>/dev/null)
      PLAYER_STATE="playing"
      CURRENT_SONG="$TRACK - $ARTIST"
    else
      PLAYER_STATE="paused"
      CURRENT_SONG=""
    fi
  else
    PLAYER_STATE="stopped"
    CURRENT_SONG=""
  fi
else
  # Use the INFO from media_change event
  PLAYER_STATE="$(echo $INFO | jq -r '.state')"
  CURRENT_SONG="$(echo $INFO | jq -r '.title + " - " + .artist')"
fi

if [ "$PLAYER_STATE" = "playing" ]; then
  ICON="􀊄"
  DRAWING="on"
  LABEL="$CURRENT_SONG"
else
  ICON="􀊆"
  DRAWING="on"  # Always show the icon
  LABEL=""       # Hide label when not playing
fi

sketchybar --set $NAME label="$LABEL" icon="$ICON" drawing="$DRAWING"
