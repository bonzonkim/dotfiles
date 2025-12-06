#!/bin/bash

battery=(
	script="$PLUGIN_DIR/battery.sh"
	icon.font="$FONT:Regular:19.0"
	# icon.color="$GREEN"
	padding_right=0
	padding_left=10
	label.drawing=on
	update_freq=120
	updates=on
)
status_bracket=(
	background.color="$BACKGROUND_1"
	background.border_color="$BACKGROUND_2"
	background.border_width=1
	background.height=30
	background.corner_radius=8
	background.drawing=on
)
sketchybar --add item battery right \
	--set battery "${battery[@]}" \
	--subscribe battery power_source_change system_woke
sketchybar --add bracket status brew vpn_alias input_source wifi_alias volume_alias battery \
	--set status "${status_bracket[@]}"
