#!/bin/bash

# 카카오톡 Nerd Font 아이콘 사용
KAKAO_ICON="󰭹"

source "$CONFIG_DIR/colors.sh"

kakao=(
	script="$PLUGIN_DIR/kakao.sh"
	icon="$KAKAO_ICON"
	icon.font="JetBrainsMono Nerd Font:Bold:16.0"
	icon.color="$WHITE"
	label.drawing=off
	padding_right=3
	padding_left=1
	update_freq=3
	updates=on
	drawing=off
)

sketchybar --add item kakao right \
	--set kakao "${kakao[@]}"
