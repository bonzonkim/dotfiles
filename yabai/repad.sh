#!/usr/bin/env bash
# Re-apply the reserved area for sketchybar after display/space changes.
# yabai v7 handles custom bar reservation through the global external_bar
# setting rather than display-scoped top_padding.

yabai -m config external_bar all:40:0
