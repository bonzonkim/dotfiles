#!/bin/bash

# 카카오톡 알림 확인 플러그인
# 카카오톡이 실행 중이면 아이콘 표시, 알림이 있으면 숫자만 표시

source "$CONFIG_DIR/colors.sh"

KAKAO_ICON="󰭹"

# 카카오톡 실행 여부 확인
KAKAO_RUNNING=$(pgrep -x "KakaoTalk" 2>/dev/null)

if [ -z "$KAKAO_RUNNING" ]; then
    # 카카오톡이 실행 중이 아니면 숨김
    sketchybar --set kakao drawing=off
    exit 0
fi

# 카카오톡이 실행 중이면 표시
# Dock 배지 확인 (알림 개수)
BADGE_INFO=$(lsappinfo info -only StatusLabel "KakaoTalk" 2>/dev/null)
BADGE_COUNT=$(echo "$BADGE_INFO" | grep -oE '"label"="[0-9]+"' | grep -oE '[0-9]+')

if [ -n "$BADGE_COUNT" ] && [ "$BADGE_COUNT" -gt 0 ]; then
    # 알림이 있으면 아이콘 + 숫자 표시
    sketchybar --set kakao \
        drawing=on \
        icon="$KAKAO_ICON" \
        icon.color="$WHITE" \
        label.drawing=on \
        label="$BADGE_COUNT" \
        label.color="$RED"
else
    # 알림 없으면 아이콘만 표시
    sketchybar --set kakao \
        drawing=on \
        icon="$KAKAO_ICON" \
        icon.color="$WHITE" \
        label.drawing=off
fi
